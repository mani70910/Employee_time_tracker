import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/Web1")
public class Web1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        JSONObject responseJson = new JSONObject();

        try {
            conn = DatabaseConnection.getConnection(); 

            
            LocalDate today = LocalDate.now();

            
            LocalDate startOfWeek = today.with(java.time.DayOfWeek.MONDAY);
            LocalDate endOfWeek = startOfWeek.plusDays(6);

            
            LocalDate startOfMonth = today.withDayOfMonth(1);
            LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

            
            String dailySql = "SELECT project, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS daily_hours "
                            + "FROM add_task "
                            + "WHERE date_1 = ? "
                            + "GROUP BY project";
            
            String weeklySql = "SELECT project, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS weekly_hours "
                             + "FROM add_task "
                             + "WHERE date_1 BETWEEN ? AND ? "
                             + "GROUP BY project";
            
            String monthlySql = "SELECT project, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS monthly_hours "
                              + "FROM add_task "
                              + "WHERE date_1 BETWEEN ? AND ? "
                              + "GROUP BY project";

            
            stmt = conn.prepareStatement(dailySql);
            stmt.setString(1, today.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray dailyProjects = new JSONArray();
            while (rs.next()) {
                JSONObject projectObj = new JSONObject();
                projectObj.put("project", rs.getString("project"));
                projectObj.put("daily_hours", Math.abs(rs.getInt("daily_hours"))); // Convert to positive using Math.abs()
                dailyProjects.add(projectObj);
            }

            stmt = conn.prepareStatement(weeklySql);
            stmt.setString(1, startOfWeek.format(DateTimeFormatter.ISO_DATE));
            stmt.setString(2, endOfWeek.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray weeklyProjects = new JSONArray();
            while (rs.next()) {
                JSONObject projectObj = new JSONObject();
                projectObj.put("project", rs.getString("project"));
                projectObj.put("weekly_hours", Math.abs(rs.getInt("weekly_hours"))); // Convert to positive using Math.abs()
                weeklyProjects.add(projectObj);
            }

            stmt = conn.prepareStatement(monthlySql);
            stmt.setString(1, startOfMonth.format(DateTimeFormatter.ISO_DATE));
            stmt.setString(2, endOfMonth.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray monthlyProjects = new JSONArray();
            while (rs.next()) {
                JSONObject projectObj = new JSONObject();
                projectObj.put("project", rs.getString("project"));
                projectObj.put("monthly_hours", Math.abs(rs.getInt("monthly_hours"))); // Convert to positive using Math.abs()
                monthlyProjects.add(projectObj);
            }

           
            responseJson.put("daily", dailyProjects);
            responseJson.put("weekly", weeklyProjects);
            responseJson.put("monthly", monthlyProjects);

            
            request.setAttribute("jsonData", responseJson.toJSONString());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/chart.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            
            responseJson.put("error", "SQL Exception: " + e.getMessage());
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(responseJson);
            out.flush();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
