package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/editVehicleServlet")
public class editVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String model = request.getParameter("model");
        String vehicleType = request.getParameter("vehicleType");
        String year = request.getParameter("year");
        String rentalPrice = request.getParameter("rentalPrice");
        String availability = request.getParameter("availability");
        String insuranceExpiryDate = request.getParameter("insuranceExpiryDate");
        String fuelType = request.getParameter("fuelType");

        // Call the editVehicle method from VehicleModel
        boolean isUpdated = UserModel.editVehicle(id, model, vehicleType, year, rentalPrice, availability, insuranceExpiryDate, fuelType);

        if (isUpdated) {
            request.setAttribute("msg", "done");
            request.getRequestDispatcher("allVehicles.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "wrong");
            request.getRequestDispatcher("allVehicles.jsp").forward(request, response);
        }
    }
}