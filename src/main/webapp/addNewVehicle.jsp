<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <script src="/docs/5.3/assets/js/color-modes.js"></script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Hugo 0.122.0">
  <title>Add New Vehicle</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    .displayMsg {
      width: 50%;
      margin: 50px auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .displayMsg h1 {
      text-align: center;
    }

    .input-style {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="displayMsg">
      <h1>Add New Vehicle</h1>
      <h1>${message}</h1> <!-- Display success or error message -->
    </div>
    
    <%
    int id = 1;
    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT MAX(id) FROM vehicle");
        if (rs.next()) {
            id = rs.getInt(1) + 1; // Increment the max ID
        }
        con.close(); // Close the connection
    } catch (Exception e) {
        e.printStackTrace(); // Log the error
    }
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
    <form action="addNewVehicleServlet" method="POST">
      <h3 style="color: yellow;">Vehicle ID: <%= id %></h3>
      <input type="hidden" name="id" value="<%= id %>">

      <div class="mb-3">
  <label for="model" class="form-label">Model</label>
  <input class="form-control input-style" id="model" type="text" name="model" placeholder="Enter Vehicle Model" required oninput="validateModel(this)">
</div>

      <div class="mb-3">
  <label for="vehicleType" class="form-label">Vehicle Type</label>
  <input class="form-control input-style" id="vehicleType" type="text" name="vehicleType" placeholder="Enter Vehicle Type" required oninput="validateVehicleType(this)">
</div>

      <div class="mb-3">
  <label for="year" class="form-label">Year</label>
  <input class="form-control input-style" id="year" type="text" name="year" placeholder="Enter Year" required oninput="validateYear(this)" maxlength="4">
</div>

      <div class="mb-3">
  <label for="rentalPrice" class="form-label">Rental Price Per Day</label>
  <input class="form-control input-style" id="rentalPrice" type="text" name="rentalPrice" placeholder="Enter Rental Price" required oninput="validateRentalPrice(this)">
</div>

      <div class="mb-3">
        <label for="availability" class="form-label">Availability</label>
        <select class="form-select input-style" id="availability" name="availability">
          <option value="available">Available</option>
          <option value="unavailable">Unavailable</option>
        </select>
      </div>

      <div class="mb-3">
  <label for="insuranceExpiryDate" class="form-label">Insurance Expiry Date</label>
  <input class="form-control input-style" id="insuranceExpiryDate" type="date" name="insuranceExpiryDate" placeholder="Enter Insurance Expiry Date" required>
</div>

      <div class="mb-3">
        <label for="fuelType" class="form-label">Fuel Type</label>
        <select class="form-select input-style" id="fuelType" name="fuelType">
          <option value="petrol">Petrol</option>
          <option value="diesel">Diesel</option>
          <option value="electric">Electric</option>
        </select>
      </div>

      <div class="d-flex justify-content-center">
        <button class="btn btn-success" type="submit">Save <i class='far fa-arrow-alt-circle-right'></i></button>
        <button class="btn btn-secondary" type="button" onclick="location.href='allVehicles.jsp'">Back</button>
      </div>
    </form>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-qTOoTdtZlwtLlFf7hxhcP7PMDcQcDmDmLZTsaG6TN78DlhG+qN+q4T7F793H" crossorigin="anonymous"></script>
</body>
</html>