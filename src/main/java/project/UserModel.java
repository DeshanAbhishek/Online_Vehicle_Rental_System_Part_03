package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserModel {
	public static boolean registerUser(String name, String email, String mobileNumber, String sequrityQuestion, String answer, String password) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, mobileNumber, sequrityQuestion, answer, password) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobileNumber);
            ps.setString(4, sequrityQuestion);
            ps.setString(5, answer);
            ps.setString(6, password);
            ps.executeUpdate();
            con.close();
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }
	
	public static boolean validateUser(String email, String password) {
        boolean isValid = false;
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + password + "'");
            isValid = rs.next();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return isValid;
    }
	
	public static boolean changePassword(String email, String mobileNumber, String sequrityQuestion, String answer, String newPassword) {
        boolean isPasswordChanged = false;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND mobileNumber=? AND sequrityQuestion=? AND answer=?");
            ps.setString(1, email);
            ps.setString(2, mobileNumber);
            ps.setString(3, sequrityQuestion);
            ps.setString(4, answer);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PreparedStatement updatePs = con.prepareStatement("UPDATE users SET password=? WHERE email=?");
                updatePs.setString(1, newPassword);
                updatePs.setString(2, email);
                updatePs.executeUpdate();
                isPasswordChanged = true;
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return isPasswordChanged;
    }
	
	public static boolean addNewVehicle(String id, String model, String vehicleType, String year, String rentalPrice, String availability, String insuranceExpiryDate, String fuelType) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("INSERT INTO vehicle (id, model, vehicleType, year, rentalPricePerDay, availability, insuranceExpiryDate, fuelType) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, Integer.parseInt(id)); // Assuming id is an integer
            ps.setString(2, model);
            ps.setString(3, vehicleType);
            ps.setInt(4, Integer.parseInt(year)); // Assuming year is an integer
            ps.setInt(5, Integer.parseInt(rentalPrice)); // Assuming rental price is an integer
            ps.setString(6, availability);
            ps.setDate(7, java.sql.Date.valueOf(insuranceExpiryDate)); // Convert String to SQL Date
            ps.setString(8, fuelType);
            int rowsAffected = ps.executeUpdate(); // Execute the update
            con.close(); // Close the connection
            return rowsAffected > 0; // Return true if rows were affected
        } catch (Exception e) {
            System.out.println(e); // Log the exception
            return false; // Return false if there was an exception
        }
    }
	
	public static boolean editVehicle(String id, String model, String vehicleType, String year, String rentalPrice, String availability, String insuranceExpiryDate, String fuelType) {
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            int rowsAffected = st.executeUpdate("UPDATE vehicle SET model='" + model + "', vehicleType='" + vehicleType + "', year='" + year + "', rentalPricePerDay='" + rentalPrice + "', availability='" + availability + "', insuranceExpiryDate='" + insuranceExpiryDate + "', fuelType='" + fuelType + "' WHERE id='" + id + "'");
            con.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }
	
	public static boolean deleteVehicle(String id) {
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            int rowsAffected = st.executeUpdate("DELETE FROM vehicle WHERE id='" + id + "'");
            con.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }
	
	

}
