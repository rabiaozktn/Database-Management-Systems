package com.company;

public class Uye {
    private String KullaniciAdi;
    private String Adi;
    private String Soyadi;
    private String _sifre;
    private String email;
    private int uyeno;

    //public Uye(String adi){this.Adi = adi;}
    public Uye(String adi,String soyadi,String kullaniciAdi,String sifre,String Email,int uyeNo){
        this.Adi = adi;
        this.Soyadi = soyadi;
        this.KullaniciAdi = kullaniciAdi;
        this._sifre = sifre;
        this.email = Email;
        this.uyeno = uyeNo;
    }



    public String getKullaniciAdi() {return KullaniciAdi;}
    public String getAdi(){ return Adi;}
    public String getSoyadi(){ return Soyadi;}
    public String getSifre(){return _sifre;}
    public String getemail(){return email;}
    public int getno(){return uyeno;}

}
