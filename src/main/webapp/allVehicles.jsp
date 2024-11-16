<%@ page import="java.text.DecimalFormat" %>
<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <script src="/docs/5.3/assets/js/color-modes.js"></script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>All Vehicles</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    .allVehicles {
      width: 100%;
      margin: 50px auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .allVehicles table {
      width: 100%;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .allVehicles th, .allVehicles td {
      text-align: center;
    }

    .alert {
      color: red;
      text-align: center;
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
    </header>

    <div class="row">
      <div class="col-md-12">
        <div class="allVehicles">
          <h2>All Vehicles</h2>
          <table>
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Model</th>
                <th scope="col">Vehicle Type</th>
                <th scope="col">Year</th>
                <th scope="col">Rental Price Per Day</th>
                <th scope="col">Availability</th>
                <th scope="col">Insurance Expiry Date</th>
                <th scope="col">Fuel Type</th>
                <th scope="col">Edit</th>
                <th scope="col">Delete</th>
              </tr>
            </thead>
            <tbody>
              <%
              String msg = request.getParameter("msg");
              if ("done".equals(msg)) {
              %>
              <h3 class="alert">Vehicle Successfully Updated!</h3>
              <% } %>
              <%
              if ("wrong".equals(msg)) {
              %>
              <h3 class="alert">Something went wrong! Try again!</h3>
              <% } %>
              <%
              try {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM vehicle");
                DecimalFormat decimalFormat = new DecimalFormat("#,##0.00"); // Create a decimal formatter
                while (rs.next()) {
                  double rentalPrice = rs.getDouble("rentalPricePerDay"); // Get the rental price as a double
                  String formattedPrice = decimalFormat.format(rentalPrice); // Format the price
              %>
              <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("model") %></td>
                <td><%= rs.getString("vehicleType") %></td>
                <td><%= rs.getString("year") %></td>
                <td><%= formattedPrice %></td> <!-- Display the formatted rental price -->
                <td><%= rs .getString("availability") %></td>
                <td><%= rs.getDate("insuranceExpiryDate") %></td>
                <td><%= rs.getString("fuelType") %></td>
                <td><a href="editVehicle.jsp?id=<%= rs.getString("id") %>">Edit</a></td>
                <td><a href="deleteVehicle.jsp?id=<%= rs.getString("id") %>">Delete</a></td>
              </tr>
              <% }
              con.close(); // Close the connection
              } catch (Exception e) {
                System.out.println(e);
              }
              %>
            </tbody>
          </table>
          <center><button onclick="location.href='addNewVehicle.jsp'">Add New Vehicle</button></center>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr38bgBIFaxYSKm+9PlTWEq1Aul69Egi0h4ycNR7GZD+2W/89V3ttD5v+N" crossorigin="anonymous"></script>
</body>
</html>