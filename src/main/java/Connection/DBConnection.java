/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class DBConnection {

    private Connection connection;
    public PreparedStatement preparedStatement;
    public Statement statement;

    public Connection Connect() {
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("dbconnectionlink", "username", "password");
            statement = connection.createStatement();
            
        } catch (Exception e) {
            System.out.println("Bağlantı hatası!");
        }
        return connection;
    }
    
    public void CloseConnection(){
        try 
        {
            if (statement != null) {
                statement.close();
                statement = null;
            }
            if (connection != null) {
                connection.close();
                connection = null;

            }
        } 
        catch (Exception e) 
        {
            System.out.println("Bağlantı kapatılamadı!");
        }        
    }    

    public static void main(String args[]) {
        DBConnection dbConnection = new DBConnection();
    }
}
