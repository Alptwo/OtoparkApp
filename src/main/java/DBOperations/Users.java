/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBOperations;

import Connection.DBConnection;
import Objects.clsUser;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.apache.commons.lang.StringEscapeUtils;

public class Users extends DBConnection {

    DBConnection dbConnection = new DBConnection();

    public void getUsers() {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblUsers;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public boolean addUser(String UserName, String Password, String UserType) {
        Boolean infomessage = true;
        try {     
            UserName = UserName.replaceAll("\\s", "");
            UserName = UserName.replaceAll("<", "");
            UserName = UserName.replaceAll(">", "");
            Connection connection = dbConnection.Connect();
            String sql = "SELECT * FROM tblUsers WHERE Username=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, UserName);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next() == false) {
                preparedStatement = connection.prepareStatement("INSERT INTO tblUsers(Username, Password, Type) VALUES (?,?,?)");
                preparedStatement.setString(1, StringEscapeUtils.escapeHtml(UserName));
                String hash_password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(Password);
                System.out.println(hash_password);
                preparedStatement.setString(2, hash_password);
                preparedStatement.setString(3, StringEscapeUtils.escapeHtml(UserType));
                preparedStatement.execute();
            } else {
                infomessage = false;
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
        return infomessage;
    }

    public void deleteUser(int id ,String AdminUserName) {
        String username="";
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT Username FROM tblUsers WHERE ID=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                username = rs.getString(1);
            }
            if (!AdminUserName.equals(username)) {
                //System.out.println(id);
                clsUser user = new clsUser();
                preparedStatement = connection.prepareStatement("DELETE FROM tblUsers WHERE ID=?");
                preparedStatement.setInt(1, id);
                preparedStatement.execute();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();

    }

    public void updateUser(String username, String password, String usertype, String AdminUserName) {
        try {
            Connection connection = dbConnection.Connect();
            if (password.equals("")) {
                preparedStatement = connection.prepareStatement("SELECT Password FROM tblUsers WHERE Username=?");
                preparedStatement.setString(1, StringEscapeUtils.escapeHtml(username));
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    password = rs.getString(1);
                }
            } else if (!password.equals("")) {
                password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
            }
            if (usertype.equals("") || AdminUserName.equals(username)) {
                preparedStatement = connection.prepareStatement("SELECT Type FROM tblUsers WHERE Username=?");
                preparedStatement.setString(1, StringEscapeUtils.escapeHtml(username));
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    usertype = rs.getString(1);
                }
            }
            preparedStatement = connection.prepareStatement("UPDATE tblUsers SET Username=?,Password=?,Type=? WHERE Username=?");
            preparedStatement.setString(1, StringEscapeUtils.escapeHtml(username));
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, StringEscapeUtils.escapeHtml(usertype));
            preparedStatement.setString(4, StringEscapeUtils.escapeHtml(username));
            preparedStatement.execute();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void getUserByID(int id) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblUsers WHERE ID=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                //System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public ArrayList<clsUser> getAllUsers() {
        ArrayList<clsUser> users = new ArrayList<>();

        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblUsers;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                clsUser usr = new clsUser();
                usr.setID(rs.getInt("ID"));
                usr.setUsername(rs.getString("Username"));
                usr.setUsertype(rs.getString("Type"));
                users.add(usr);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public static void main(String args[]) {
        Users users = new Users();
        //users.addUser("mehmet","1233","Admin");
        //users.deleteUser(24);
        //users.updateUser("ugur", "123", "Admin");
        //users.getUserByID(5);
        users.getUsers();
    }

}
