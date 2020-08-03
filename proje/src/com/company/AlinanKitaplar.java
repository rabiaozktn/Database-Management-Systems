package com.company;

public class AlinanKitaplar {
    private int AKNo;
    private int KitapNo;
    private  int UyeNo;

    public AlinanKitaplar(int akno,int kitapno,int uyeNo){
        this.AKNo = akno;
        this.KitapNo = kitapno;
        this.UyeNo = uyeNo;
    }

    public int getAKNo() {
        return AKNo;
    }
    public int getKitapNo() {
        return KitapNo;
    }
    public int getUyeNo() {
        return UyeNo;
    }
}
