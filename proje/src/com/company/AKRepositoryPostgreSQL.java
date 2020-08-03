package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class AKRepositoryPostgreSQL {

    private Connection baglan(){
        Connection conn = null;
        try{
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/rabia2",
                    "postgres", "hello123");
            if(conn != null){
                System.out.println("Veritabanına bağlandı!");
            }
            else
                System.out.println("Bağlantı Grişimi başarısız.");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public void kaydet(AlinanKitaplar AK) {
        String sql = "INSERT INTO  \"AlinanKitaplar\" (\"AKNo\",\"KitapNo\",\"UyeNo\") VALUES(\'" + AK.getAKNo() + "\',\'" + AK.getKitapNo() + "\',\'" + AK.getUyeNo() + "\')";
        Connection conn = this.baglan();
        try {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
