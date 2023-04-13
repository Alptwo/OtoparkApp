/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBOperations;

import Connection.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import org.apache.commons.lang.StringEscapeUtils;

public class Login extends DBConnection {

    DBConnection dbConnection = new DBConnection();

    public int Login(String username, String password) {
        int canLogin = 0;
        try {
            Connection connection = dbConnection.Connect();
            boolean isPasswordtrue = false;

            String sql = "SELECT * FROM tblUsers WHERE Username=? AND Password=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, StringEscapeUtils.escapeHtml(username));
            String hash_password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
            preparedStatement.setString(2, hash_password);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                System.out.println(" GİRİŞ BAŞARILI");
                canLogin = 1;
                isPasswordtrue = true;
            }
            if (!isPasswordtrue) {
                System.out.println("GİRİŞ BAŞARISIZ");
                canLogin = 0;
            }
        } catch (Exception e) {
        }
        dbConnection.CloseConnection();
        return canLogin;
    }

    public boolean isAdmin(String username, String password) {
        boolean isAdmin = false;
        try {
            Connection connection = dbConnection.Connect();
            String sql = "SELECT * FROM tblUsers WHERE Username=? AND Password=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, StringEscapeUtils.escapeHtml(username));
            String hash_password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
            preparedStatement.setString(2, hash_password);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                if (rs.getString(4).equals("Admin")) {
                    isAdmin = true;
                } else {
                    isAdmin = false;
                }
            }
        } catch (Exception e) {
        }
        dbConnection.CloseConnection();
        return isAdmin;
    }

    public static void main(String args[]) {
        Login login = new Login();
    }

}
