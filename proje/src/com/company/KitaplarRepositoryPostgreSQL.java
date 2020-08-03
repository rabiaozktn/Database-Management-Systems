package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class KitaplarRepositoryPostgreSQL {
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

    public Kitap ara(int kullan){
        System.out.println("Uye aranıyor...");
        Kitap kitap= null;

        String sql= "SELECT * FROM \"Kitaplar\" WHERE \"KitapNo\"="+kullan;
        Connection conn = this.baglan();
        try{
            Statement stmt  = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            conn.close();

            int KitapNo;
            int Isbn;
            String adi;
            int sayfa;
            int yayinevino;
            int kategorino;
            int dilno;

            while(rs.next())
            {
                // Kayda ait alan değerlerini değişkene ata //
                KitapNo  = rs.getInt("KitapNo");
                Isbn = rs.getInt("ISBN");
                adi  = rs.getString("KitapAdi");
                yayinevino = rs.getInt("YayinEviNo");
                kategorino = rs.getInt("KategoriNo");
                sayfa  = rs.getInt("SayfaSayisi");
                dilno = rs.getInt("DilNo");

                kitap = new Kitap(KitapNo,Isbn,adi,yayinevino,kategorino,sayfa,dilno);
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e ){
            e.printStackTrace();
        }
        return kitap;
    }
    public void tumUrunler(){

        System.out.println("ürünleri getiriyor...");

        Connection conn=this.baglan();

        try{
            String sql= "SELECT \"KitapNo\", \"ISBN\", \"KitapAdi\",\"YayinEviNo\",\"KategoriNo\",\"SayfaSayisi\",\"DilNo\"  FROM \"Kitaplar\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            int KitapNo;
            int Isbn;
            String adi;
            int sayfa;
            int yayinevino;
            int kategorino;
            int dilno;


            while(rs.next())
            {
                KitapNo  = rs.getInt("KitapNo");
                Isbn = rs.getInt("ISBN");
                adi  = rs.getString("KitapAdi");
                yayinevino = rs.getInt("YayinEviNo");
                kategorino = rs.getInt("KategoriNo");
                sayfa  = rs.getInt("SayfaSayisi");
                dilno = rs.getInt("DilNo");

                System.out.print("KitapNo:"+KitapNo);
                System.out.print(" ISBN: "+ Isbn);
                System.out.print(" Kitap Adı: "+adi);
                System.out.print(" Yayın Evi No: "+yayinevino);
                System.out.print(" Kategori No: "+kategorino);
                System.out.print(" Sayfa Sayısı: "+sayfa);
                System.out.println(" Dil Kodu: "+dilno);
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void kaydet(Kitap Kitap){
        String sql= "INSERT INTO  \"Kitaplar\" (\"KitapNo\",\"ISBN\",\"KitapAdi\",\"YayinEviNo\",\"KategoriNo\",\"SayfaSayisi\",\"DilNo\") VALUES(\'"+Kitap.getKitapNo()+"\',\'"+Kitap.getISBN()+"\',\'"+Kitap.getKitapAdi()+"\',\'"+Kitap.getYayinEviNo()+"\',\'"+Kitap.getKategoriNo()+"\',\'"+Kitap.getSayfaSayisi()+"\',\'"+Kitap.getDilNo()+"\')";
        Connection conn=this.baglan();
        try
        {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sil(int kitapNo){
        System.out.println("ürün siliniyor...");

        String sql= "DELETE FROM \"Kitaplar\" WHERE \"KitapNo\"="+kitapNo;

        Connection conn=this.baglan();
        try{
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
