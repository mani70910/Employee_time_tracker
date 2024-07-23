<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Task Form</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
 <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #CAADD9;
      background-image: linear-gradient(to right, #9BE772, #3b3b3b);
      color: white;
      background-size: cover; 
      background-position: center; 
      background-repeat: no-repeat;
    }
    .container {
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      background-color: rgba(255, 255, 255, 0.1);
      border-radius: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }
    .form-group label {
      font-weight: bold;
    }
    .form-group input[type="text"], 
    .form-group input[type="date"], 
    .form-group input[type="time"], 
    .form-group textarea {
      border-radius: 20px !important;
      background-color: rgba(255, 255, 255, 0.1);
      color: white;
    }
    .form-group input::placeholder, 
    .form-group textarea::placeholder {
      color: #ccc;
    }
    .card {
      background-color: rgba(0, 0, 0, 0.6);
      padding: 20px;
      border-radius: 20px;
    }
    .card h2 {
      color: #fff;
    }
    .btn-primary {
      background-color: #4CAF50;
      border: none;
    }
    .btn-primary:hover {
      background-color: #45a049;
    }
    .home-btn {
      background-color: #009688;
      border: none;
      margin-bottom: 20px;
    }
    .home-btn:hover {
      background-color: #00796b;
    }
    #footer {
      margin-top: 50px;
      text-align: center;
      padding: 10px;
      background-color: #090979;
      color: white;
      font-weight: bold;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="card p-4">
    <h2 class="text-center">ADD TASK</h2>
    <div class="btn-container">
      <a href="home1.jsp" class="btn btn-primary home-btn">Home</a>
    </div>
    <form id="taskForm" action='add1' method='post'>
      <div class="form-group">
        <label for="task_id"><i class="bi bi-key"></i> Task ID</label>
        <input type="text" class="form-control" id="task_id" name="task_id" placeholder="Automatically generated" readonly>
      </div>
      <div class="form-group">
        <label for="username"><i class="bi bi-key"></i> Username</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username">
      </div>
      <div class="form-group">
        <label for="employee_name"><i class="bi bi-person"></i> Employee Name</label>
        <input type="text" class="form-control" id="employee_name" name="employee_name" placeholder="Enter Employee Name">
      </div>
      <div class="form-group">
        <label for="project"><i class="bi bi-journal"></i> Project</label>
        <input type="text" class="form-control" id="project" name="project" placeholder="Enter Project Name">
      </div>
      <div class="form-group">
        <label for="date_1"><i class="bi bi-calendar"></i> Date</label>
        <input type="date" class="form-control" id="date_1" name="date_1" placeholder="Select Date">
      </div>
      <div class="form-group">
        <label for="start_time"><i class="bi bi-clock"></i> Start Time</label>
        <input type="time" class="form-control" id="start_time" name="start_time" placeholder="Select Start Time">
      </div>
      <div class="form-group">
        <label for="end_time"><i class="bi bi-clock"></i> End Time</label>
        <input type="time" class="form-control" id="end_time" name="end_time" placeholder="Select End Time">
      </div>
      <div class="form-group">
        <label for="task_category"><i class="bi bi-card-checklist"></i> Task Category</label>
        <input type="text" class="form-control" id="task_category" name="task_category" placeholder="Enter Task Category">
      </div>
      <div class="form-group">
        <label for="description"><i class="bi bi-textarea"></i> Description</label>
        <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter Task Description"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
  </div>
</div>

<footer id="footer">
  © 2024 Employee Operations Dashboard.
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
  // Function to generate a random task ID
  function generateTaskId() {
    return Math.floor(Math.random() * 10000); 
  }

  // Function to check if the task ID is unique (placeholder for actual implementation)
  function isTaskIdUnique(taskId) {
    // Implement the actual check in the backend
    return true;
  }

  // On DOM content loaded
  document.addEventListener('DOMContentLoaded', function() {
    // Generate and set a unique task ID
    let taskId = generateTaskId();
    while (!isTaskIdUnique(taskId)) {
      taskId = generateTaskId();
    }
    document.getElementById('task_id').value = taskId;

    // Display error message if present
    const errorMessage = '<%= (String) request.getAttribute("errorMessage") %>';
    if (errorMessage && errorMessage.trim() !== 'null') {
      alert(errorMessage.trim());
    }
  });

  
  document.getElementById('taskForm').addEventListener('submit', function(event) {
    event.preventDefault(); 

    let dateInput = document.getElementById('date_1').value;
    let currentDate = new Date().toISOString().split('T')[0]; 

    
    if (dateInput < currentDate) {
      alert('Cannot add task for a date earlier than today.');
      return; 
    }

    this.submit();
  });
</script>
</body>
</html>
