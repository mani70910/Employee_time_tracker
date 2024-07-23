<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.css" crossorigin="">
    <style>
        /* Reset and basic styling */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0; /* Adjust as needed */
            margin: 0;
        }

        .header {
            width: 100%;
            background-color: #ff0000 ; /* Header background color */
            color: #fff; /* Header text color */
            padding: 1rem 0;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Shadow effect */
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header__home {
            position: absolute;
            top: 1rem;
            left: 1rem;
            text-decoration: none;
            color: #fff;
            font-size: 1.2rem;
        }

        .login__form {
            width: 100%;
            max-width: 400px; /* Adjust the max-width to your preference */
            padding: 2rem;
            background-color: rgba(255, 255, 255, 0.9); /* Adjust the opacity as needed */
            border-radius: 1rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Improved shadow effect */
            backdrop-filter: blur(10px); /* Blur effect for modern browsers */
            margin-top: 2rem;
        }

        .login__title {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }

        .login__inputs {
            margin-bottom: 1.5rem;
        }

        .login__box {
            display: flex;
            align-items: center;
            border: 2px solid #ccc;
            border-radius: 0.5rem;
            padding: 0.5rem;
        }

        .login__input {
            flex: 1;
            border: none;
            outline: none;
            padding: 0.5rem;
            font-size: 1rem;
        }

        .login__input::placeholder {
            color: #888;
        }

        .login__box i {
            font-size: 1.25rem;
            margin-right: 0.5rem;
        }

        .login__button {
            width: 100%;
            padding: 1rem;
            background-color: #007bff; /* Your button background color */
            color: #fff; /* Your button text color */
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .login__button:hover {
            background-color: #0056b3; /* Hover background color */
        }
    </style>
    <title>Login form</title>
</head>
<body>
    <header class="header">
        <a href="main.jsp" class="header__home">Home</a>
        <h1>Admin Dashboard</h1>
    </header>

    <div class="login">
        <form id="loginForm" class="login__form" action="index" method="post">
            <h2 class="login__title">Admin Login</h2>
            <div class="login__inputs">
                <div class="login__box">
                    <input type="text" id="adminId" name="username" placeholder="Admin ID" required class="login__input">
                    <i class="ri-mail-fill"></i>
                </div>
                <div class="login__box">
                    <input type="password" id="password" name="password" placeholder="Password" required class="login__input">
                    <i class="ri-lock-2-fill"></i>
                </div>
            </div>
            <button type="submit" class="login__button">Login</button>
        </form>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            event.preventDefault();

            const adminId = document.getElementById('adminId').value;
            const password = document.getElementById('password').value;

            if (adminId === 'admin' && password === 'admin') {
                window.location.href = 'home1.jsp'; // Replace with your target page
            } else {
                alert('Invalid Admin ID or Password');
            }
        });
    </script>
</body>
</html>
