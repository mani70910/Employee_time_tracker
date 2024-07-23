<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee and Admin Page</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://celigent.com/wp-content/uploads/2023/11/what_is_the_impact_of_change_in_a_projects_life_cycle__1701290904.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #333;
        }

        .container {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.85);
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 90%;
            margin: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        h1 {
            margin-bottom: 30px;
            font-size: 24px;
            color: #333;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        button {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 30px;
            margin: 20px 0;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
            color: white;
            width: 250px;
        }

        button img {
            width: 24px;
            height: 24px;
        }

        button#employeeBtn {
            background-color: #4CAF50; 
        }

        button#adminBtn {
            background-color: #f44336; 
        }

        button:hover {
            transform: scale(1.05);
        }

        button:active {
            transform: scale(0.95);
        }

        .button-text {
            flex-grow: 1;
            text-align: center;
        }

        footer {
            margin-top: 20px;
            font-size: 14px;
        }

        a {
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #007BFF;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Employee Time Tracker</h1>
        <div class="btn-container">
            <a href="home1.jsp" class="btn btn-primary home-btn">Home</a>
        </div>
        <div class="button-container">
            <button id="employeeBtn">
                   <span class="button-text">Employee</span>
               
            </button>
            <button id="adminBtn">
                 
                <span class="button-text">Admin</span>
               
            </button>
        </div>
        <footer id="footer">
   ......© 2024 Employee Operations Dashboard.
</footer>
    </div>
    
    <script>
    document.getElementById('employeeBtn').addEventListener('click', function() {
        window.location.href = "index.jsp";
    });


        document.getElementById('adminBtn').addEventListener('click', function() {
        	window.location.href = "index1.jsp";
        });
    </script>
</body>
</html>