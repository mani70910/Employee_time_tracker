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
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
        padding: 20px;
        overflow-x: auto; /* Enable horizontal scrolling if needed */
    }
    .box {
        flex: 0 0 auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        color: #333;
        text-decoration: none;
        transition: transform 0.3s ease;
        min-width: 200px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .box:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    .icon {
        font-size: 48px;
        margin-bottom: 10px;
    }
    .text {
        font-size: 18px;
        font-weight: bold;
    }
    #loadedContent {
        display: none;
        margin-top: 20px;
        width: 100%;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 20px;
        background-color: #fff;
        color: #333;
    }
    #logout {
        color: white;
        text-decoration: none;
        font-style: italic;
    }
    #footer {
        margin-top: auto;
        text-align: center;
        padding: 10px;
        background-color: #333;
        color: #fff;
    }
</style>
</head>
<body>
<header>
    <h1><%= request.getSession().getAttribute("username") %> Employee Operations Dashboard</h1>
    <a href="index.jsp" id="logout">Log Out</a>
</header>

<div class="container">
    <a href="add.jsp" class="box">
        <div class="icon"><i class="fas fa-tasks"></i></div>
        <div class="text">Add Task</div>
        <p>Adding New Task.</p>
    </a>
    <a href="edit.jsp" class="box">
        <div class="icon"><i class="fas fa-edit"></i></div>
        <div class="text">Edit</div>
        <p>Edit Given Task.</p>
    </a>
    
    <a href="Web" class="box">
        <div class="icon"><i class="fas fa-eye"></i></div>
        <div class="text">View</div>
        <p>View Given Task.</p>
    </a>
</div>

<div id="loadedContent"></div>

<footer id="footer">
    © 2024 Employee Operations Dashboard. All rights reserved.
</footer>

<script>
    // Function to load content dynamically
    function loadContent(url) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var loadedContent = document.getElementById('loadedContent');
                loadedContent.style.display = 'block'; // Show the loaded content
                loadedContent.innerHTML = xhr.responseText;
            }
        };
        xhr.send();
    }
</script>

</body>
</html>
