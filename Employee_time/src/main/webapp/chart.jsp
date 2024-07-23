<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Task Hours Dashboard</title>
    <!-- Include Chart.js library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000;
            color: #fff;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #090909; 
            font-size: 2em; 
            margin-bottom: 20px; 
            background-color: #79F237; 
            padding: 10px; 
            border-radius: 5px; 
        }

        .chart-container {
            width: 25%;
            display: inline-block;
            margin: 20px 1%;
            background-color: #111;
            padding: 20px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        .large-chart-container {
            width: 50%;
            display: inline-block;
            margin: 20px 1%;
            background-color: #111;
            padding: 20px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        .full-width-chart {
            width: 60%;
            margin: 20px auto;
            background-color: #111;
            padding: 20px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        canvas {
            max-width: 100%;
        }
    </style>
</head>
<body>
    <h2>Task Hours Dashboard</h2>

   
    <div class="chart-container">
        <canvas id="dailyChart"></canvas>
    </div>

    
    <div class="large-chart-container">
        <canvas id="weeklyChart"></canvas>
    </div>

   
    <div class="full-width-chart">
        <canvas id="monthlyChart"></canvas>
    </div>
    <footer id="footer">
   ......© 2024 Employee Operations Dashboard.
</footer>

    <script>
        // Retrieve JSON data from the servlet
        var jsonData = '<%= request.getAttribute("jsonData") %>';
        
        // Parse JSON data into JavaScript object
        var data = JSON.parse(jsonData);

        // Function to create chart
        function createChart(ctx, type, label, labels, data, backgroundColor, borderColor) {
            new Chart(ctx, {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        label: label,
                        data: data,
                        backgroundColor: backgroundColor,
                        borderColor: borderColor,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Daily Chart
        var dailyProjects = data.daily.map(item => item.project);
        var dailyHours = data.daily.map(item => item.daily_hours);
        var dailyColors = dailyProjects.length ? [
            'rgba(255, 99, 132, 0.7)',
            'rgba(54, 162, 235, 0.7)',
            'rgba(255, 206, 86, 0.7)',
            'rgba(75, 192, 192, 0.7)',
            'rgba(153, 102, 255, 0.7)',
            'rgba(255, 159, 64, 0.7)'
        ] : ['rgba(165, 42, 42, 0.7)'];

        createChart(document.getElementById('dailyChart').getContext('2d'),
                    'pie', 'Daily Task Hours',
                    dailyProjects.length ? dailyProjects : ['No Tasks'],
                    dailyProjects.length ? dailyHours : [0],
                    dailyColors);

        // Weekly Chart
        var weeklyProjects = data.weekly.map(item => item.project);
        var weeklyHours = data.weekly.map(item => item.weekly_hours);
        var weeklyColors = weeklyProjects.length ? 'rgba(54, 162, 235, 0.7)' : 'rgba(165, 42, 42, 0.7)';

        createChart(document.getElementById('weeklyChart').getContext('2d'),
                    'bar', 'Weekly Task Hours',
                    weeklyProjects.length ? weeklyProjects : ['No Tasks'],
                    weeklyProjects.length ? weeklyHours : [0],
                    weeklyColors);

        // Monthly Chart
        var monthlyProjects = data.monthly.map(item => item.project);
        var monthlyHours = data.monthly.map(item => item.monthly_hours);
        var monthlyColors = monthlyProjects.length ? 'rgba(54, 162, 235, 0.7)' : 'rgba(165, 42, 42, 0.7)';

        createChart(document.getElementById('monthlyChart').getContext('2d'),
                    'bar', 'Monthly Task Hours',
                    monthlyProjects.length ? monthlyProjects : ['No Tasks'],
                    monthlyProjects.length ? monthlyHours : [0],
                    monthlyColors);
    </script>

</body>
</html>
