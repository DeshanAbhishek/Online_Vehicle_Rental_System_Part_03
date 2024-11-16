<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <script src="/docs/5.3/assets/js/color-modes.js"></script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Delete Vehicle</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    html, body {
        height: 100%; /* Ensure the body and html take full height */
        margin: 0; /* Remove default margin */
    }

    .container {
        display: flex; /* Use Flexbox */
        flex-direction: column; /* Stack children vertically */
        justify-content: center; /* Center vertically */
        align-items: center; /* Center horizontally */
        height: 100vh; /* Full height of the viewport */
    }

    .deleteVehicle {
        width: 80%; /* Width of the form */
        max-width: 600px; /* Optional max width */
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #fff; /* White background for contrast */
    }

    .deleteVehicle form {
        display: flex;
        flex-direction: column; /* Stack fields vertically */
        color:black;
    }

    .field-group {
        display: flex; /* Use Flexbox for field groups */
        justify-content: space-between; /* Space between label and input */
        margin-bottom: 20px; /* Space between fields */
    }

    .field-group h3 {
        margin: 0; /* Remove margin from headings */
        width: 45%; /* Set width for labels */
    }

    .field-group input[type="text"],
    .field-group input[type="number"],
    .field-group select {
        width: 50%; /* Set width for input fields */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .deleteVehicle button {
        width: 100%;
        padding: 10px;
        background-color: #808080;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .deleteVehicle button:hover {
        background-color: #666666;
    }

    .delete-vehicle-label {
        text-align: center;
        margin-bottom: 20px;
    }

    .back {
        color: white;
        margin-left: 2.5%;
    }
  </style>
</head>

<body>
  <div class="container">
    <header>
      <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container">
          <a href="home.jsp" class="navbar-brand d-flex align-items-center">
            <strong>RVR</strong>
          </a>
        </div>
      </div>
      <div class="delete-vehicle-label">
        <h1>Delete Vehicle</h1>
      </div>
    </header>

    <div class="deleteVehicle">
      <h2><a class="back" href="allVehicles.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></h2>
      <%
      String id = request.getParameter("id");
      try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM vehicle WHERE id='" + id + "'");
        if (rs.next()) {
      %>
      <form action="deleteVehicleServlet" method="POST">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="field-group">
          <h3>Model</h3>
          <input class="input-style" type="text" name="model" value="<%= rs.getString("model") %>" readonly>
        </div>

        <div class="field-group">
          <h3>Vehicle Type</h3>
          <input class="input-style" type="text" name="vehicleType" value="<%= rs.getString("vehicleType") %>" readonly>
        </div>

        <div class="field-group">
          <h3>Year</h3>
          <input class="input-style" type="number" name="year" value="<%= rs.getString("year") %>" readonly>
        </div>

        <div class="field-group">
          <h3>Rental Price Per Day</h3>
          <input class="input-style" type="number" name="rentalPrice" value="<%= rs.getString("rentalPricePerDay") %>" readonly>
        </div>

        <div class="field-group">
          <h3>Availability</h3>
          <select class="input-style" name="availability">
            <option value="yes">Yes</option>
            <option value="no">No</option>
          </select>
        </div>

        <div class="field-group">
          <h3>Insurance Expiry Date</h3>
          <input class="input-style" type="date" name="insuranceExpiryDate" value="<%= rs.getString("insuranceExpiryDate") %>" readonly>
        </div>

        <div class="field-group">
          <h3>Fuel Type</h3>
          <input class="input-style" type="text" name="fuelType" value="<%= rs.getString("fuelType") %>" readonly>
        </div>

        <button class="button" style="background-color: #808080;">Delete <i class='far fa-arrow-alt-circle-right'></i></button>
      </form>
      <%
      }
      } catch (Exception e) {
        System.out.print(e);
      }
      %>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr38bgBIFaxYSKm+9PlTWEq1Aul69Egi0h4ycNR7GZD+2W/89V3ttD5v+N" crossorigin="anonymous"></script>
</body>
</html>