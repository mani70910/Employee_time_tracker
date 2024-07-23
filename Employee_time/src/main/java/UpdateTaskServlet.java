import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String employeeName = request.getParameter("employeeName");
        String project = request.getParameter("project");
        String date1 = request.getParameter("date1");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String taskCategory = request.getParameter("taskCategory");
        String description = request.getParameter("description");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
           
            connection = DatabaseConnection.getConnection();

           
            String sql = "UPDATE add_task SET employee_name = ?, project = ?, date_1 = ?, start_time = ?, end_time = ?, task_category = ?, description = ? WHERE task_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, employeeName);
            statement.setString(2, project);
            statement.setString(3, date1);
            statement.setString(4, startTime);
            statement.setString(5, endTime);
            statement.setString(6, taskCategory);
            statement.setString(7, description);
            statement.setInt(8, taskId);

            
            int rowsUpdated = statement.executeUpdate();

            
            String message;
            if (rowsUpdated > 0) {
                message = "Task updated successfully.";
            } else {
                message = "Failed to update task.";
            }

            
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>Task Update</title>");
            out.println("<style>");
            out.println(".alert { padding: 20px; background-color: #f44336; color: white; margin-bottom: 15px; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; }");
            out.println(".closebtn { margin-left: 15px; color: white; font-weight: bold; float: right; font-size: 22px; line-height: 20px; cursor: pointer; transition: 0.3s; }");
            out.println(".closebtn:hover { color: black; }");
            out.println("</style></head><body>");
            out.println("<div class='alert'>");
            out.println("<span class='closebtn' onclick='this.parentElement.style.display=\"none\";'>&times;</span>");
            out.println(message);
            out.println("</div>");
            out.println("<script>setTimeout(() => { window.location.href = 'modify.jsp'; }, 3000);</script>"); // Redirect to dashboard after 3 seconds
            out.println("</body></html>");

        } catch (SQLException ex) {
            throw new ServletException("Database access error!", ex);
        } finally {
           
        	try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close(); 
                }
            } catch (SQLException ex) {
                throw new ServletException("Error closing resources!", ex);
            }
        }
    }
}
