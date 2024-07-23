<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Operations Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome CSS -->
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            padding: 15px;
            background-color: rgb(62, 80, 170);
            box-sizing: border-box;
            text-align: center;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container {
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 6px 12px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-view { background-color: #2196F3; }
        .btn-edit { background-color: #FF9800; }
        .btn-delete { background-color: #F44336; }
        #footer {
            margin-top: auto;
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
        }
        .header__home {
           /* position: absolute;*/
            top: 1rem;
            right: 1rem;
            text-decoration: none;
            color: #fff;
            font-size: 1.2rem;
        }
        .logout {
            /*position: absolute;*/
            top: 1rem;
            right: 1rem;
            text-decoration: none;
            color: #fff;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
<header>
    <h1>Employee Operations Dashboard</h1>
     <a href="home1.jsp" class="header__home">Home</a>
    <a href="index1.jsp" class="logout">Log Out</a>
</header>

<div class="container">
    <h2>Task List</h2>
    <table id="taskTable">
        <thead>
            <tr>
                <th>Task ID</th>
                <th>Username</th>
                <th>Employee Name</th>
                <th>Project</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Data will be dynamically inserted here -->
        </tbody>
    </table>
</div>

<footer id="footer">
   ......© 2024 Employee Operations Dashboard.
</footer>

<script>

    // Function to load task data
    function loadTasks() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'UserDetailsServlet1', true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                var taskTableBody = document.getElementById('taskTable').getElementsByTagName('tbody')[0];
                
                // Clear existing rows
                taskTableBody.innerHTML = '';

                response.tasks.forEach(function(task) {
                    var row = taskTableBody.insertRow();
                    row.insertCell(0).innerText = task.task_id;
                    row.insertCell(1).innerText = task.username;
                    row.insertCell(2).innerText = task.employee_name;
                    row.insertCell(3).innerText = task.project;
                    row.insertCell(4).innerText = task.date_1;
                    row.insertCell(5).innerText = task.start_time;
                    row.insertCell(6).innerText = task.end_time;
                    row.insertCell(7).innerText = task.task_category;
                    row.insertCell(8).innerText = task.description;

                    // Actions cell
                    var actionsCell = row.insertCell(9);
                    var actionsDiv = document.createElement('div');
                    actionsDiv.className = 'actions';
                    
                    var viewButton = document.createElement('button');
                    viewButton.className = 'btn btn-view';
                    viewButton.innerHTML = '<i class="fas fa-eye"></i>';
                    viewButton.onclick = function() { viewTask(task.task_id); };
                    actionsDiv.appendChild(viewButton);
                    
                    var editButton = document.createElement('button');
                    editButton.className = 'btn btn-edit';
                    editButton.innerHTML = '<i class="fas fa-edit"></i>';
                    editButton.onclick = function() { editTask(task); };
                    actionsDiv.appendChild(editButton);

                    var deleteButton = document.createElement('button');
                    deleteButton.className = 'btn btn-delete';
                    deleteButton.innerHTML = '<i class="fas fa-trash-alt"></i>';
                    deleteButton.onclick = function() { deleteTask(task.task_id); };
                    actionsDiv.appendChild(deleteButton);

                    actionsCell.appendChild(actionsDiv);
                });
            }
        };
        xhr.send();
    }

    // Placeholder functions for actions
    function viewTask(taskId) {
        alert('View details for Task ID: ' + taskId);
    }
    
    function editTask(task) {
        // Store task data in sessionStorage
        sessionStorage.setItem('currentTask', JSON.stringify(task));

        // Redirect to modify.jsp
        window.location.href = 'modify1.jsp';
    }

    function deleteTask(taskId) {
        if (confirm('Are you sure you want to delete Task ID: ' + taskId + '?')) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'delete', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert('Deleted Task ID: ' + taskId);
                    loadTasks(); // Refresh the task list
                }
            };
            xhr.send('task_id=' + taskId);
            window.onload = loadTasks;
        }
    }

    // Load tasks on page load
    window.onload = loadTasks;
</script>

</body>
</html>
