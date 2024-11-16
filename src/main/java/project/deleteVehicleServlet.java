package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteVehicleServlet")
public class deleteVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        // Call the deleteVehicle method from VehicleModel
        boolean isDeleted = UserModel.deleteVehicle(id);

        if (isDeleted) {
            request.setAttribute("message", "Successfully Deleted");
            request.getRequestDispatcher("allVehicles.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Something Went Wrong! Try Again !");
            request.getRequestDispatcher("allVehicles.jsp").forward(request, response);
        }
    }
}