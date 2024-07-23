import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/UserDetailsServlet")
public class UserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        PrintWriter out = response.getWriter();

        
        JSONObject jsonResponse = new JSONObject();
        JSONArray taskArray = new JSONArray();

        try {
            Connection connection = DatabaseConnection.getConnection();

            
            String sql = "SELECT task_id, username, employee_name, project, date_1, start_time, end_time, task_category, description FROM add_task WHERE username = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);

            ResultSet resultSet = statement.executeQuery();

            
            while (resultSet.next()) {
                JSONObject taskDetails = new JSONObject();
                taskDetails.put("task_id", resultSet.getInt("task_id"));
                taskDetails.put("username", resultSet.getString("username"));
                taskDetails.put("employee_name", resultSet.getString("employee_name"));
                taskDetails.put("project", resultSet.getString("project"));
                taskDetails.put("date_1", resultSet.getDate("date_1").toString());
                taskDetails.put("start_time", convertTo12HourFormat(resultSet.getTime("start_time").toString()));
                taskDetails.put("end_time", convertTo12HourFormat(resultSet.getTime("end_time").toString()));
                taskDetails.put("task_category", resultSet.getString("task_category"));
                taskDetails.put("description", resultSet.getString("description"));
                taskArray.add(taskDetails);
            }

            resultSet.close();
            statement.close();
            connection.close();

            jsonResponse.put("username", username);
            jsonResponse.put("tasks", taskArray);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
            return;
        }

       
        out.print(jsonResponse.toString());
        out.flush();
        
    }
    private String convertTo12HourFormat(String time24) {
        try {
            DateFormat inputFormat = new SimpleDateFormat("HH:mm:ss");
            DateFormat outputFormat = new SimpleDateFormat("hh:mm a");
            Date date = inputFormat.parse(time24);
            return outputFormat.format(date);
        } catch (Exception e) {
            e.printStackTrace();
            return time24; // Return original if conversion fails
        }
    }
}
