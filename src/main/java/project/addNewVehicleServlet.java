package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addNewVehicleServlet")
public class addNewVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String id = request.getParameter("id");
        String model = request.getParameter("model");
        String vehicleType = request.getParameter("vehicleType");
        String year = request.getParameter("year");
        String rentalPrice = request.getParameter("rentalPrice");
        String availability = request.getParameter("availability");
        String insuranceExpiryDate = request.getParameter("insuranceExpiryDate");
        String fuelType = request.getParameter("fuelType");

        // Call the model method to add the new vehicle
        boolean isAdded = UserModel.addNewVehicle(id, model, vehicleType, year, rentalPrice, availability, insuranceExpiryDate, fuelType);

        // Set the success or error message based on the result
        if (isAdded) {
            request.setAttribute("message", "Vehicle Successfully Added");
            request.getRequestDispatcher("allVehicles.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Something Went Wrong! Try Again!");
            request.getRequestDispatcher("addNewVehicle.jsp").forward(request, response);
        }
    }
}