<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <script src="/docs/5.3/assets/js/color-modes.js"></script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Edit Vehicle</title>
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

    .editVehicle {
        width: 80%; /* Width of the form */
        max-width: 600px; /* Optional max width */
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #fff; /* White background for contrast */
        
    }

    .editVehicle form {
        display: flex;
        flex-direction: column;
        align-items: center;
        color:black;
    }

    .editVehicle input[type="text"],
    .editVehicle input[type="date"],
    .editVehicle input[type="number"],
    .editVehicle select {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .editVehicle button {
        width: 100%;
        padding: 10px;
        background-color: #808080;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .editVehicle button:hover {
        background-color: #666666;
    }

    .back {
        color: black; /* Change back link color for contrast */
        margin-left: 2.5%;
    }

    .edit-vehicle-label {
        text-align: center;
        margin-bottom: 20px;
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
      <div class="edit-vehicle-label">
        <h1>Edit Vehicle</h1>
      </div>
    </header>

    <div class="editVehicle">
      <h2><a class ="back" href="allVehicles.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></h2>
      <%
      String id = request.getParameter("id");
      try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM vehicle WHERE id='" + id + "'");
        if (rs.next()) {
      %>
      <script>
  function validateModel(input) {
    let value = input.value;
    let regex = /^[a-zA-Z ]+$/;
    if (!regex.test(value)) {
      input.value = value.replace(/[^a-zA-Z ]/g, '');
    }
  }
  
  function validateVehicleType(input) {
	    let value = input.value;
	    let regex = /^[a-zA-Z ]+$/;
	    if (!regex.test(value)) {
	      input.value = value.replace(/[^a-zA-Z ]/g, '');
	    }
	  }
  
  function validateYear(input) {
	    let value = input.value;
	    // Regular expression to allow only digits
	    let regex = /^\d{0,4}$/; // Allow 0 to 4 digits
	    if (!regex.test(value)) {
	      input.value = value.replace(/[^0-9]/g, ''); // Remove non-digit characters
	    }
	  }
  
  function validateRentalPrice(input) {
	    let value = input.value;
	    // Regular expression to allow only positive numbers with up to 2 decimal places
	    let regex = /^\d*\.?\d{0,2}$/; // Allow digits with optional decimal point and up to 2 decimal places

	    // Remove invalid characters
	    if (!regex.test(value)) {
	      input.value = value.replace(/[^0-9.]/g, ''); // Remove non-numeric characters except for the decimal point
	    }

	    // Prevent multiple decimal points
	    const parts = input.value.split('.');
	    if (parts.length > 2) {
	      input.value = parts[0] + '.' + parts[1]; // Keep only the first decimal point
	    }

	    // Ensure that the value does not start with a decimal point
	    if (input.value.startsWith('.')) {
	      input.value = input.value.substring(1);
	    }

	    // Ensure that there are no more than 2 decimal places
	    if (parts.length === 2 && parts[1].length > 2) {
	      input.value = parts[0] + '.' + parts[1].substring(0, 2); // Limit to 2 decimal places
	    }
	  }
  
  function setMinDate() {
	    const today = new Date();
	    const dd = String(today.getDate()).padStart(2, '0');
	    const mm = String(today.getMonth() + 1).padStart(2, '0');
	    const yyyy = today.getFullYear();
	    const minDate = `${yyyy}-${mm}-${dd}`;
	    document.getElementById('insuranceExpiryDate').setAttribute('min', minDate);
	  }

	  window.onload = setMinDate;
</script>
      <form action="editVehicleServlet" method="POST">
  <input type="hidden" name="id" value="<%= id %>">
  
  <h3>Model</h3>
  <input type="text" name="model" value="<%= rs.getString("model") %>" required oninput="validateModel(this)">

  <h3>Vehicle Type</h3>
  <input type="text" name="vehicleType" value="<%= rs.getString("vehicleType") %>" required oninput="validateVehicleType(this)">

  <h3>Year</h3>
  <input type="number" name="year" value="<%= rs.getString("year") %>" required oninput="validateYear(this)">

  <h3>Rental Price Per Day</h3>
  <input type="text" name="rentalPrice" value="<%= rs.getString("rentalPricePerDay") %>" required oninput="validateRentalPrice(this)">

  <h3>Availability</h3>
  <select name="availability">
    <option value="yes" <%= "yes".equals(rs.getString("availability")) ? "selected" : "" %>>Yes</option>
    <option value="no" <%= "no".equals(rs.getString("availability")) ? "selected" : "" %>>No</option>
  </select>

  <h3>Insurance Expiry Date</h3>
  <input type="date" id="insuranceExpiryDate" name="insuranceExpiryDate" value="<%= rs.getString("insuranceExpiryDate") %>" required>

  <h3>Fuel Type</h3>
  <input type="text" name="fuelType" value="<%= rs.getString("fuelType") %>" required>

  <button class="button" style="background-color: #808080;">Save </i></button>
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