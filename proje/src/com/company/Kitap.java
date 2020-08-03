package com.company;

public class Kitap {
    private int KitapNo;
    private int ISBN;
    private String KitapAdi;
    private int YayinEviNo;
    private int KategoriNo;
    private int SayfaSayisi;
    private  int DilNo;

    public Kitap(int kitapNo,int Isbn,String kitapAdi, int yayinEviNo,int kategoriNo,int sayfaSayisi,int dilNo){
        this.KitapNo = kitapNo;
        this.ISBN = Isbn;
        this.KitapAdi = kitapAdi;
        this.YayinEviNo = yayinEviNo;
        this.KategoriNo = kategoriNo;
        this.SayfaSayisi = sayfaSayisi;
        this.DilNo = dilNo;
    }

    public int getKitapNo(){ return KitapNo;}
    public int getISBN(){return ISBN;}
    public String getKitapAdi(){return KitapAdi;}
    public int getYayinEviNo(){return YayinEviNo;}
    public int getKategoriNo(){return KategoriNo;}
    public int getSayfaSayisi(){return SayfaSayisi;}
    public  int getDilNo(){return DilNo;}
}
