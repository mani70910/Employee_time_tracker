<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In / Sign Up</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
body {
	font-family: Arial, sans-serif;
	background-color: #C5B4E1;
	background-image: linear-gradient(to right top, #6f9de4, #0094c2, #008490, #0e705d,
		#365a34);
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	width: 400px;
	background-color: #fff;
	background-image: linear-gradient(to right top, #adb1b8, #b5bec2, #c0caca, #cfd6d2,
		#dfe1db);
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
}

form {
	display: flex;
	flex-direction: column;
}

label {
	margin-bottom: 5px;
}

input[type="text"], input[type="password"] {
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

button {
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}

.switch {
	text-align: center;
	margin-top: 20px;
}

.switch a {
	text-decoration: none;
	color: #007bff;
	cursor: pointer;
}

/* Popup style */
.popup-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
}

.popup-container {
	background-color: #fff;
	background-image: linear-gradient(to right top, #adb1b8, #b5bec2, #c0caca, #cfd6d2,
		#dfe1db);
	width: 400px; /* Adjust width */
	height: 450px; /* Adjust height */
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.popup-close {
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
}

.icon {
	margin-right: 5px;
}

.back-link {
	text-align: center;
	margin-top: 20px;
}

.back-link a {
	text-decoration: none;
	color: #007bff;
	cursor: pointer;
}
</style>
</head>
<body>
    <div class="container">
        <h1>Sign In</h1>
        <form action="signin" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit"><i class="fas fa-sign-in-alt icon"></i>Sign In</button>
        </form>
        <div class="switch">
            <p>Don't have an account? <a id="signupLink"><i class="fas fa-user-plus icon"></i>Sign Up</a></p>
        </div>
    </div>

    <!-- Sign Up Popup -->
    <div class="popup-overlay" id="signupPopup">
        <div class="popup-container">
            <span class="popup-close" id="signupClose">&times;</span>
            <h1>Sign Up</h1>
            <form action="index" method="POST">
            <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required>
                >
                <label for="newPassword">Password:</label>
                <input type="password" id="password" name="password" required>
                <button type="submit"><i class="fas fa-user-plus icon"></i>Sign Up</button>
            </form>
            <div class="back-link">
                <a id="backToSignIn"><i class="fas fa-arrow-left icon"></i>Back to Sign In</a>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const signupLink = document.getElementById("signupLink");
            const signupPopup = document.getElementById("signupPopup");
            const signupClose = document.getElementById("signupClose");
            const backToSignIn = document.getElementById("backToSignIn");

            signupLink.addEventListener("click", function() {
                signupPopup.style.display = "flex";
            });

            signupClose.addEventListener("click", function() {
                signupPopup.style.display = "none";
            });

            backToSignIn.addEventListener("click", function() {
                signupPopup.style.display = "none";
            });
        });
        document.addEventListener("DOMContentLoaded", function() {
            const signupLink = document.getElementById("signupLink");
            const signupPopup = document.getElementById("signupPopup");
            const signupClose = document.getElementById("signupClose");
            const backToSignIn = document.getElementById("backToSignIn");
            const signupForm = signupPopup.querySelector("form");
            const passwordInput = signupForm.querySelector('input[name="password"]');

            signupLink.addEventListener("click", function() {
                signupPopup.style.display = "flex";
            });

            signupClose.addEventListener("click", function() {
                signupPopup.style.display = "none";
            });

            backToSignIn.addEventListener("click", function() {
                signupPopup.style.display = "none";
            });

            signupForm.addEventListener("submit", function(event) {
                const password = passwordInput.value;
                const passwordPattern = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[@#$%^&+=]).{8,}$/;

                if (!passwordPattern.test(password)) {
                    event.preventDefault();
                    alert("Password must contain at least 8 characters, including one digit, one letter, and one special character.");
                }
            });
        });

    </script>
</body>
</html>
