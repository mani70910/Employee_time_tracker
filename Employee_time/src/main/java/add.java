import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add")
public class add extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String taskId = request.getParameter("task_id");
        String username = request.getParameter("username");
        String employeeName = request.getParameter("employee_name");
        String project = request.getParameter("project");
        String date = request.getParameter("date_1");
        String startTimeStr = request.getParameter("start_time");
        String endTimeStr = request.getParameter("end_time");
        String taskCategory = request.getParameter("task_category");
        String description = request.getParameter("description");

        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
           
            conn = DatabaseConnection.getConnection();

            
            Time startTime = Time.valueOf(startTimeStr + ":00");
            Time endTime = Time.valueOf(endTimeStr + ":00");

            
            String totalHoursSql = "SELECT SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60.0 AS total_hours " +
                                   "FROM add_task WHERE username = ? AND date_1 = ?";
            stmt = conn.prepareStatement(totalHoursSql);
            stmt.setString(1, username);
            stmt.setString(2, date);
            rs = stmt.executeQuery();

            if (rs.next() && rs.getDouble("total_hours") + 
                (endTime.getTime() - startTime.getTime()) / (1000.0 * 60.0 * 60.0) > 8.0) {
                
                request.setAttribute("errorMessage", "Cannot add more than 8 hours of tasks for the day.");
                request.getRequestDispatcher("/add.jsp").forward(request, response);
                return;
            }

            
            String checkSql = "SELECT COUNT(*) FROM add_task WHERE username = ? AND date_1 = ? " +
                              "AND ((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) " +
                              "OR (? <= start_time AND ? >= end_time))";
            stmt = conn.prepareStatement(checkSql);
            stmt.setString(1, username);
            stmt.setString(2, date);
            stmt.setTime(3, startTime);
            stmt.setTime(4, startTime);
            stmt.setTime(5, endTime);
            stmt.setTime(6, endTime);
            stmt.setTime(7, startTime);
            stmt.setTime(8, endTime);

            rs = stmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                
                request.setAttribute("errorMessage", "Task with overlapping time already exists for the user on the same day.");
                request.getRequestDispatcher("/add.jsp").forward(request, response);
            } else {
                
                String insertSql = "INSERT INTO add_task (task_id, username, employee_name, project, date_1, start_time, end_time, task_category, description) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, taskId);
                stmt.setString(2, username);
                stmt.setString(3, employeeName);
                stmt.setString(4, project);
                stmt.setString(5, date);
                stmt.setTime(6, startTime);
                stmt.setTime(7, endTime);
                stmt.setString(8, taskCategory);
                stmt.setString(9, description);

                
                stmt.executeUpdate();

                
                response.sendRedirect(request.getContextPath() + "/add.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
            request.setAttribute("errorMessage", "Error: Failed to add task. Please try again.");
            request.getRequestDispatcher("/add.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
           
            request.setAttribute("errorMessage", "Error: Invalid time format. Please use HH:MM format.");
            request.getRequestDispatcher("/add.jsp").forward(request, response);
        } finally {
            
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
