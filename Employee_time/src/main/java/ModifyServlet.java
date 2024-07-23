import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;

@WebServlet("/ModifyServlet")
public class ModifyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            JSONObject errorJson = new JSONObject();
            errorJson.put("error", "No user is logged in.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(errorJson.toString());
            return;
        }

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet result = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM add_task WHERE username = ?";
            statement = conn.prepareStatement(sql);
            statement.setString(1, username);

            result = statement.executeQuery();

            if (result.next()) {
                int taskId = result.getInt("task_id");
                String employeeName = result.getString("employee_name");
                String project = result.getString("project");
                String date1 = result.getString("date_1");
                String startTime = result.getString("start_time");
                String endTime = result.getString("end_time");
                String taskCategory = result.getString("task_category");
                String description = result.getString("description");

                JSONObject json = new JSONObject();
                json.put("taskId", taskId);
                json.put("username", username);
                json.put("employeeName", employeeName);
                json.put("project", project);
                json.put("date1", date1);
                json.put("startTime", startTime);
                json.put("endTime", endTime);
                json.put("taskCategory", taskCategory);
                json.put("description", description);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json.toString());
            } else {
                JSONObject errorJson = new JSONObject();
                errorJson.put("error", "Username not found.");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(errorJson.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (statement != null) {
                    statement.close();
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
