/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Objects;

import java.sql.Date;
import java.sql.Timestamp;

public class clsEntries {
    private int id;
    private String platenumber = "";
    private Timestamp entrytime;
    private Timestamp exittime;
    private int cartypeid = -1;
    private String cartypename = "";
    private double price;
    private boolean isactive = false;
    private String IsCarInorOut = "";
    
    
    public int getID(){
        return this.id;
    }
    public void setID(int id){
        this.id = id;
    }
    
    public String getPlateNumber() {
        return this.platenumber;
    }

    public void setPlatenumber(String platenumber) {
        this.platenumber = platenumber;
    }

    public Timestamp getEntrytime() {
        return this.entrytime;
    }

    public void setEntrytime(Timestamp entrytime) {
        this.entrytime = entrytime;
    }

    public Timestamp getExittime() {
        return this.exittime;
    }

    public void setExittime(Timestamp exittime) {
        this.exittime = exittime;
    }

    public int getCartypeid() {
        return this.cartypeid;
    }

    public void setCartypeid(int cartypeid) {
        this.cartypeid = cartypeid;
    }

    public double getPrice() {
        return this.price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean getIsactive() {
        return this.isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }
    
    public void setIsCarInorOut(boolean IsActive)
    {
        if(IsActive == true)
        {
            this.IsCarInorOut  = "İçerde";
        }    
        else
        {
            this.IsCarInorOut  = "Dışarda";
        } 
    }
    
    public String getIsCarInorOut()
    {
        return this.IsCarInorOut;
    }
    
    public void setCarTypeName(int cartypeid){
        if(cartypeid == 1)
        {
            this.cartypename = "Otomobil";
        }
        else if(cartypeid == 2)
        {
            this.cartypename = "Ağır Vasıta";
        }
        else if(cartypeid == 3)
        {
            this.cartypename = "Motosiklet";
        }
    }
    
    public String getCarTypeName()
    {
        return this.cartypename;
    }
}
