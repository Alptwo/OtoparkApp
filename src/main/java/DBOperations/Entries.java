/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBOperations;

import Connection.DBConnection;
import Objects.clsEntries;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import org.apache.commons.lang.StringEscapeUtils;

public class Entries extends DBConnection {

    DBConnection dbConnection = new DBConnection();

    public String getDateTimeNow() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        return dtf.format(now);
    }

    public LocalDate getDate() {
        LocalDate today = LocalDate.now();
        return today;
    }

    public LocalDate getTomorrowsDate() {
        LocalDate today = LocalDate.now();
        LocalDate tomorrow = today.plusDays(1);
        return tomorrow;
    }

    public double calculatePrice(int id) {
        double price = 0;
        Timestamp exitdatetime = null;
        Timestamp entrydatetime = null;
        long hours = 1;
        try {
            exitdatetime = Timestamp.valueOf(getDateTimeNow());
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT E.EntryTime, CT.Price FROM tblEntries E INNER JOIN tblCarTypes CT ON E.CarTypeID = CT.ID WHERE E.ID=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                entrydatetime = rs.getTimestamp(1);
                price = rs.getInt(2);
                hours = (int) ((exitdatetime.getTime() - entrydatetime.getTime()) / 3600000);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (hours == 0) {
            hours = 1;
        }
        //System.out.println("Price:"+price+" | Hours:"+hours+" | EntryDateTime:"+entrydatetime+" | ExitDateTime:"+exitdatetime+" | Ücret:"+price*hours);
        return price * hours;
    }

    public int calculateEmptySpace() {
        int space = 30;
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT E.ID, CT.Size FROM tblEntries E INNER JOIN tblCarTypes CT ON E.CarTypeID = CT.ID WHERE IsActive=true;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                space = space - rs.getInt(2);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return space;
    }

    public float calculateDailyEarnings() {
        float earning = 0;
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblEntries WHERE ExitTime > ? AND ExitTime < ?");
            preparedStatement.setString(1, getDate().toString());
            preparedStatement.setString(2, getTomorrowsDate().toString());
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                earning += rs.getFloat(6);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return earning;
    }

    public void getEntries() {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblEntries");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + "\t" + rs.getString(6) + "\t" + rs.getString(7));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public boolean IsThatPlateIn(String PlateNumber) {
        boolean isIN = true;
        boolean control = false;
        try {
            Connection connection = dbConnection.Connect();
            String sql = "SELECT PlateNumber FROM tblEntries WHERE IsActive = true AND PlateNumber=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, PlateNumber);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                isIN = true;
                control = true;
            }
            if (!control) {
                isIN = false;
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isIN;
    }

    public String addEntry(String platenumber, String cartypename) {
        String infomessage = "Lütfen tüm alanları doldurunuz!";        
        try {
            platenumber = platenumber.replaceAll("\\s", "");
            platenumber = platenumber.replaceAll("<", "");
            platenumber = platenumber.replaceAll(">", "");            
            if (IsThatPlateIn(platenumber)) {
                infomessage = "Bu araç zaten içerde!";
            } else if (platenumber.equals("") != true && cartypename != null) {
                int carsize = 0;
                int cartypeid = 0;
                Connection con = dbConnection.Connect();
                String sql = "SELECT CT.Size,CT.ID FROM tblCarTypes CT WHERE CT.Name=?";
                preparedStatement = con.prepareStatement(sql);
                preparedStatement.setString(1, cartypename);
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    carsize = rs.getInt(1);
                    cartypeid = rs.getInt(2);
                }
                con.close();
                if (calculateEmptySpace() - carsize >= 0) {
                    Connection connection = dbConnection.Connect();
                    preparedStatement = connection.prepareStatement("INSERT INTO tblEntries(PlateNumber, EntryTime, CarTypeID, Price, IsActive) VALUES (?,?,?,'0','1')");
                    preparedStatement.setString(1, StringEscapeUtils.escapeHtml(platenumber.toUpperCase()));
                    preparedStatement.setString(2, getDateTimeNow());
                    preparedStatement.setInt(3, cartypeid);
                    preparedStatement.execute();
                    infomessage = "Kayıt başarıyla eklendi.";
                } else {
                    infomessage = "Otoparkta yer yok!";
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
        return infomessage;
    }

    public void deleteEntry(int id) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("DELETE FROM tblEntries WHERE ID=?");
            preparedStatement.setInt(1, id);
            preparedStatement.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void updateExit(int id) {
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblEntries WHERE ID=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();            
            while (rs.next()) {
                PreparedStatement pstmt = connection.prepareStatement("UPDATE tblEntries SET ExitTime='" + getDateTimeNow() + "',Price='" + calculatePrice(id) + "', IsActive='0' WHERE ID='" + id + "'");
                pstmt.executeUpdate();
                /*
                Connection connection2 = dbConnection.Connect();
                preparedStatement = connection2.prepareStatement("UPDATE tblEntries SET (ExitTime=?, Price=?, IsActive=0) WHERE ID=?");
                preparedStatement.setString(1, getDateTimeNow());
                preparedStatement.setDouble(2, calculatePrice(id));
                preparedStatement.setInt(3, id);
                preparedStatement.execute();
                */
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public void getEntryByID(int id) {
        try {
            Connection connection = dbConnection.Connect();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tblEntries WHERE ID='" + id + "'");
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + "\t" + rs.getString(6) + "\t" + rs.getString(7));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        dbConnection.CloseConnection();
    }

    public ArrayList<clsEntries> getAllEntries() {
        ArrayList<clsEntries> entries = new ArrayList<>();
        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblEntries WHERE IsActive=false;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                clsEntries entry = new clsEntries();
                entry.setPlatenumber(rs.getString("PlateNumber"));
                entry.setEntrytime(rs.getTimestamp("EntryTime"));
                entry.setExittime(rs.getTimestamp("ExitTime"));
                entry.setCarTypeName(rs.getInt("CarTypeID"));
                entry.setIsCarInorOut(rs.getBoolean("IsActive"));
                entry.setPrice(rs.getFloat("Price"));
                entries.add(entry);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return entries;
    }

    public ArrayList<clsEntries> getAllActiveEntries() {
        ArrayList<clsEntries> entries = new ArrayList<>();

        try {
            Connection connection = dbConnection.Connect();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblEntries WHERE IsActive=true;");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                clsEntries entry = new clsEntries();
                entry.setID(rs.getInt("ID"));
                entry.setPlatenumber(rs.getString("PlateNumber"));
                entry.setEntrytime(rs.getTimestamp("EntryTime"));
                entry.setExittime(rs.getTimestamp("ExitTime"));
                entry.setCarTypeName(rs.getInt("CarTypeID"));
                entry.setIsCarInorOut(rs.getBoolean("IsActive"));
                entry.setPrice(rs.getFloat("Price"));
                entries.add(entry);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return entries;
    }

    public static void main(String args[]) {
        Entries entries = new Entries();
        //entries.addEntry("test test test", "Motosiklet");
        //entries.deleteEntry(210);
        //entries.updateExit(13);
        //entries.getEntryByID(1);
        //entries.getEntries();
        //entries.getAllEntries();
        //entries.getAllActiveEntries();
        //entries.calculateDailyEarnings();
        //System.out.println(entries.calculatePrice(350));
    }
}
