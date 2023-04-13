/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBOperations;

import Connection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CarTypes extends DBConnection{

    DBConnection dbConnection = new DBConnection();

    public void getCarTypes() {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblCarTypes;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void addCarType(String name, double Price, int size) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("INSERT INTO tblCarTypes(Name,Price,Size) VALUES (?,?,?)");
            preparedStatement.setString(1, name);
            preparedStatement.setDouble(2, Price);
            preparedStatement.setInt(3, size);
            preparedStatement.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void deleteCarType(int id) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("DELETE FROM tblCarTypes WHERE ID=?");
            preparedStatement.setInt(1, id);
            preparedStatement.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void updateCarType(int id, String name, double price, int size) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("UPDATE tblCarTypes SET Name=?,Price=?,Size=? WHERE ID=?");
            preparedStatement.setString(1, name);
            preparedStatement.setDouble(1, price);
            preparedStatement.setInt(1, size);
            preparedStatement.setInt(1, id);            
            preparedStatement.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void getCarTypeByID(int id) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblCarTypes WHERE ID=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public static void main(String args[]) {
        CarTypes cartypes = new CarTypes();
        //cartypes.addCarType("bisiklet", 5, 1);
        //cartypes.deleteCarType(3);
        //cartypes.updateCarType(4, "Motor", 10, 1);
        //cartypes.getCarTypeByID(2);
        //cartypes.getCarTypes();
    }
}
