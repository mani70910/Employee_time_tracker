<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 20px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
        }
        .section {
            flex: 1;
            padding: 10px;
            box-sizing: border-box;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], textarea {
            width: calc(100% - 20px); /* Adjust width based on padding */
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
        }
        button:hover {
            background-color: #0056b3;
        }
        /* Gradient Background */
        .gradient-background {
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.7)); /* Adjust colors and opacity as needed */
            height: 200px; /* Adjust height as needed */
            border-top: 1px solid #ccc; /* Optional: add border for separation */
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Retrieve task data from sessionStorage
            var taskData = JSON.parse(sessionStorage.getItem('currentTask'));

            // Populate form fields with task data
            document.getElementById('taskId').value = taskData.task_id;
            document.getElementById('username').value = taskData.username;
            document.getElementById('employeeName').value = taskData.employee_name;
            document.getElementById('project').value = taskData.project;
            document.getElementById('date1').value = taskData.date_1;
            document.getElementById('startTime').value = taskData.start_time;
            document.getElementById('endTime').value = taskData.end_time;
            document.getElementById('taskCategory').value = taskData.task_category;
            document.getElementById('description').value = taskData.description;
        });
    </script>
</head>
<body>
    <h2>Modify Task</h2>
    <div class="container">
        <form action="UpdateTaskServlet" method="POST">
            <div class="section">
                <label for="taskId">Task ID:</label>
                <input type="text" id="taskId" name="taskId" readonly>
                
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" readonly>
                
                <label for="employeeName">Employee Name:</label>
                <input type="text" id="employeeName" name="employeeName" required>
            </div>
            <div class="section">
                <label for="project">Project:</label>
                <input type="text" id="project" name="project" required>
                
                <label for="date1">Date:</label>
                <input type="date" id="date1" name="date1" required>
                
                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime" required>
                
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime" required>
                
                <label for="taskCategory">Category:</label>
                <input type="text" id="taskCategory" name="taskCategory" required>
            </div>
            <div class="section">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="5" required></textarea>
                
                <div class="button-container">
                    <button type="submit">Update Task</button>
                    <a href="edit.jsp">Cancel</a>
                </div>
            </div>
        </form>
    </div>
    <div class="gradient-background"></div>
</body>
</html>
