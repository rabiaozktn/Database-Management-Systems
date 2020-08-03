--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: aktifyazarlarsayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.aktifyazarlarsayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM "Yazarlar" WHERE "AktifMi" = TRUE;
   RETURN total;
END;
$$;


ALTER FUNCTION public.aktifyazarlarsayisi() OWNER TO postgres;

--
-- Name: kategoridekikitaplar(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kategoridekikitaplar() RETURNS TABLE(kategorino integer, kitapadi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Kategoriler"."KategoriAdi","Kitaplar"."KitapAdi"
FROM "Kategoriler"
INNER JOIN "Kitaplar"
ON "Kategoriler"."KategoriNo"="Kitaplar"."KategoriNo"
ORDER BY "Kategoriler"."KategoriNo" ASC;
END;
$$;


ALTER FUNCTION public.kategoridekikitaplar() OWNER TO postgres;

--
-- Name: kayitEkleTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."kayitEkleTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."Adi" = UPPER(NEW."Adi"); -- büyük harfe dönüştürdükten sonra ekle
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."kayitEkleTR1"() OWNER TO postgres;

--
-- Name: log_yazaradi_degisikligi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_yazaradi_degisikligi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.YazarAdi <> OLD.YazarAdi THEN
		 INSERT INTO Uyeler(UyeNo,YazarAdi)
		 VALUES(OLD.UyeNo,OLD.YazarAdi);
	END IF;

	RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_yazaradi_degisikligi() OWNER TO postgres;

--
-- Name: toplam_ders_kitabi_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_ders_kitabi_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM "Kitaplar" WHERE "KategoriNo" = 1;
   RETURN total;
END;
$$;


ALTER FUNCTION public.toplam_ders_kitabi_sayisi() OWNER TO postgres;

--
-- Name: toplamkitap(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamkitap() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM "Kitaplar";
   RETURN total;
END;
$$;


ALTER FUNCTION public.toplamkitap() OWNER TO postgres;

--
-- Name: ak_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ak_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.ak_seq OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: AlinanKitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AlinanKitaplar" (
    "AKNo" integer DEFAULT nextval('public.ak_seq'::regclass) NOT NULL,
    "KitapNo" integer NOT NULL,
    "UyeNo" integer NOT NULL,
    "AktifM" boolean
);


ALTER TABLE public."AlinanKitaplar" OWNER TO postgres;

--
-- Name: bkno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bkno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.bkno_seq OWNER TO postgres;

--
-- Name: BagislananKitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BagislananKitaplar" (
    "BKNo" integer DEFAULT nextval('public.bkno_seq'::regclass) NOT NULL,
    "UyeNo" integer NOT NULL,
    "KitapNo" integer NOT NULL
);


ALTER TABLE public."BagislananKitaplar" OWNER TO postgres;

--
-- Name: dilno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dilno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.dilno_seq OWNER TO postgres;

--
-- Name: Diller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Diller" (
    "DilNo" integer DEFAULT nextval('public.dilno_seq'::regclass) NOT NULL,
    "DilAdi" character varying(2044) NOT NULL
);


ALTER TABLE public."Diller" OWNER TO postgres;

--
-- Name: ikno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ikno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.ikno_seq OWNER TO postgres;

--
-- Name: IstenenKitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IstenenKitaplar" (
    "IstekNo" integer DEFAULT nextval('public.ikno_seq'::regclass) NOT NULL,
    "KitapAdi" character varying(2044) NOT NULL,
    "UyeNo" integer NOT NULL
);


ALTER TABLE public."IstenenKitaplar" OWNER TO postgres;

--
-- Name: kno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.kno_seq OWNER TO postgres;

--
-- Name: Kategoriler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kategoriler" (
    "KategoriNo" integer DEFAULT nextval('public.kno_seq'::regclass) NOT NULL,
    "KategoriAdi" character varying(2044) NOT NULL
);


ALTER TABLE public."Kategoriler" OWNER TO postgres;

--
-- Name: ktno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ktno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.ktno_seq OWNER TO postgres;

--
-- Name: KayitTurleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KayitTurleri" (
    "KayitTurNo" integer DEFAULT nextval('public.ktno_seq'::regclass) NOT NULL,
    "KayitTurAciklama" text NOT NULL
);


ALTER TABLE public."KayitTurleri" OWNER TO postgres;

--
-- Name: Kitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kitaplar" (
    "KitapNo" integer DEFAULT nextval('public.kno_seq'::regclass) NOT NULL,
    "ISBN" integer NOT NULL,
    "KitapAdi" character varying(2044) NOT NULL,
    "YayinEviNo" integer NOT NULL,
    "KategoriNo" integer NOT NULL,
    "SayfaSayisi" integer NOT NULL,
    "YayinTarihi" date,
    "AlanKullaniciNo" integer,
    "DilNo" integer NOT NULL,
    "AldigiTarih" date
);


ALTER TABLE public."Kitaplar" OWNER TO postgres;

--
-- Name: bilgino_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bilgino_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.bilgino_seq OWNER TO postgres;

--
-- Name: KütüphaneBilgileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KütüphaneBilgileri" (
    "BilgiNo" integer DEFAULT nextval('public.bilgino_seq'::regclass) NOT NULL,
    "KitapSayisi" integer NOT NULL,
    "BagislanmisKitapSayisi" integer NOT NULL,
    "YayınEviSayisi" integer,
    "KategoriSayisi" integer NOT NULL,
    "DilSayisi" integer NOT NULL,
    "UyeSayisi" integer NOT NULL,
    "KitapIhtiyaciSayisi" integer NOT NULL,
    "YazarSayisi" integer NOT NULL
);


ALTER TABLE public."KütüphaneBilgileri" OWNER TO postgres;

--
-- Name: uyeno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uyeno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.uyeno_seq OWNER TO postgres;

--
-- Name: Ogrenciler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogrenciler" (
    "UyeNo" integer DEFAULT nextval('public.uyeno_seq'::regclass) NOT NULL,
    "KayitTurNo" integer NOT NULL
);


ALTER TABLE public."Ogrenciler" OWNER TO postgres;

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "UyeNo" integer DEFAULT nextval('public.uyeno_seq'::regclass) NOT NULL,
    "DepartmanAciklamasi" character varying(2044),
    "GorevAciklamasi" character varying(2044)
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: Uyeler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uyeler" (
    "UyeNo" integer NOT NULL,
    "KullaniciAdi" character varying(2044) NOT NULL,
    "Adi" character varying(2044) NOT NULL,
    "Soyadi" character varying(2044) NOT NULL,
    _sifre character varying(2044) NOT NULL,
    email character varying(2044) NOT NULL,
    "AdminMi" bit(2044),
    "AktifMi" bit(2044)
);


ALTER TABLE public."Uyeler" OWNER TO postgres;

--
-- Name: yeno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yeno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.yeno_seq OWNER TO postgres;

--
-- Name: Yayınevleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yayınevleri" (
    "PublisherNo" integer DEFAULT nextval('public.yeno_seq'::regclass) NOT NULL,
    "PublisherName" character varying(2044) NOT NULL,
    "PhoneNo" character varying(2044) NOT NULL,
    "PublisherAdress" text NOT NULL,
    "Email" character varying(2044) NOT NULL,
    "WebURL" text NOT NULL,
    "isActiv" boolean NOT NULL
);


ALTER TABLE public."Yayınevleri" OWNER TO postgres;

--
-- Name: ykno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ykno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.ykno_seq OWNER TO postgres;

--
-- Name: YazarKitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."YazarKitap" (
    "YKNo" integer DEFAULT nextval('public.ykno_seq'::regclass) NOT NULL,
    "KitapNo" integer NOT NULL,
    "YazarNo" integer NOT NULL
);


ALTER TABLE public."YazarKitap" OWNER TO postgres;

--
-- Name: yazarno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yazarno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.yazarno_seq OWNER TO postgres;

--
-- Name: Yazarlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazarlar" (
    "YazarNo" integer DEFAULT nextval('public.yazarno_seq'::regclass) NOT NULL,
    "YazarAdi" character varying(2044) NOT NULL,
    "TelefonNo" character varying(2044) NOT NULL,
    "Email" character varying(2044) NOT NULL,
    "AktifMi" boolean
);


ALTER TABLE public."Yazarlar" OWNER TO postgres;

--
-- Name: istekno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.istekno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.istekno_seq OWNER TO postgres;

--
-- Name: kayitno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kayitno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.kayitno_seq OWNER TO postgres;

--
-- Name: kitapno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kitapno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.kitapno_seq OWNER TO postgres;

--
-- Data for Name: AlinanKitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AlinanKitaplar" VALUES
	(2, 2, 3, false),
	(3, 3, 1, false),
	(4, 4, 3, false),
	(5, 5, 1, false),
	(6, 5, 1, false),
	(8, 3, 1, false),
	(9, 10, 1, false),
	(1, 1, 1, true),
	(7, 6, 1, true);


--
-- Data for Name: BagislananKitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."BagislananKitaplar" VALUES
	(1, 1, 1),
	(3, 1, 3),
	(4, 3, 4),
	(2, 1, 2),
	(6, 1, 8),
	(7, 1, 10);


--
-- Data for Name: Diller; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Diller" VALUES
	(3, 'Ispanyolca'),
	(8, 'Turkce'),
	(9, 'Ingilizce'),
	(13, 'Tayca'),
	(14, 'Korece'),
	(15, 'Japonca'),
	(16, 'Fince');


--
-- Data for Name: IstenenKitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."IstenenKitaplar" VALUES
	(2, 'Java', 7),
	(3, 'Git', 1),
	(4, 'JS', 3);


--
-- Data for Name: Kategoriler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kategoriler" VALUES
	(1, 'Korku'),
	(2, 'Ders'),
	(3, 'Bilim'),
	(4, 'Kurgu'),
	(5, 'Macera');


--
-- Data for Name: KayitTurleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KayitTurleri" VALUES
	(1, 'Onlisans'),
	(2, 'Lisans'),
	(3, 'YuksekLisans'),
	(4, 'Doktora'),
	(5, 'Erasmu');


--
-- Data for Name: Kitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kitaplar" VALUES
	(1, 12312312, 'C++ Programlama', 2, 1, 350, '1920-02-19', NULL, 8, '2010-02-19'),
	(2, 1231231, 'c#', 2, 1, 450, '2010-05-05', NULL, 8, '2020-05-05'),
	(5, 567890123, 'ReactJs', 3, 1, 100, '2019-12-09', NULL, 9, '2019-12-09'),
	(6, 98765432, 'T-SQL Egitimi', 3, 1, 150, '2019-12-09', NULL, 3, '2019-12-09'),
	(7, 987654321, 'React Native Kitap', 3, 1, 170, '2019-12-09', NULL, 9, '2019-12-09'),
	(9, 765432109, 'MSSQL', 3, 1, 210, '2019-12-09', NULL, 9, '2019-12-09'),
	(10, 555555555, 'Visual Studio', 2, 1, 310, '2019-12-09', NULL, 8, '2010-05-05'),
	(3, 2312312, 'Integral', 2, 1, 150, '2010-05-05', NULL, 8, '2020-05-05'),
	(4, 456789012, 'Lineer Cebir', 2, 1, 200, '2019-12-07', 1, 8, '2010-02-19'),
	(8, 876543210, 'Serway', 3, 1, 200, '2019-12-09', NULL, 9, '2010-05-05');


--
-- Data for Name: KütüphaneBilgileri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KütüphaneBilgileri" VALUES
	(1, 10, 6, 3, 5, 7, 4, 3, 6);


--
-- Data for Name: Ogrenciler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ogrenciler" VALUES
	(1, 3),
	(3, 3),
	(7, 2);


--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Personel" VALUES
	(6, 'İdari', 'Müdür');


--
-- Data for Name: Uyeler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Uyeler" VALUES
	(3, 'kullanici2', 'mehmet', 'ali', '321', 'mehmet@gmail.com', NULL, NULL),
	(6, 'kullanici3', 'ayşe', 'ak', '213', 'ayşe@gmail.com', NULL, NULL),
	(7, 'kullanici4', 'fatma', 'al', '312', 'fatma@gmail.com', NULL, NULL),
	(1, 'yılmazali', 'yılmaz', 'ali', '123', 'yılmaz@gmail.com', NULL, NULL),
	(2, 'ye', 'YıLMAZ', 'erdoğan', '321', 'yılmazerdo@gmail.com', NULL, NULL);


--
-- Data for Name: Yayınevleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yayınevleri" VALUES
	(2, 'kemal yayıncılık', '123456789', 'Sakarya', 'kemal@gmail.com', 'kemal.com', false),
	(3, 'Limon yayınclık', '988775321', 'Kars', 'kars@gmail.com', 'kars.com', false),
	(4, 'Su yayıncılk', '234263464', 'Denizli', 'su@gmail.com', 'su.com', false);


--
-- Data for Name: YazarKitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."YazarKitap" VALUES
	(1, 2, 1),
	(2, 2, 3),
	(3, 1, 1),
	(4, 1, 2),
	(5, 4, 1),
	(6, 3, 1),
	(7, 3, 2),
	(8, 3, 3),
	(9, 5, 1),
	(10, 6, 5),
	(12, 6, 5);


--
-- Data for Name: Yazarlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yazarlar" VALUES
	(1, 'Recai', '5515525534', 'recai@hotmail.com', true),
	(3, 'ekrem', '1231241251', 'ekrem@gmail.com', true),
	(2, 'Mahmut', '1234112341', 'mahmut@gmail.com', false),
	(4, 'George', '1231231244', 'george@gmail.com', true),
	(5, 'RR', '8465418916', 'rr@gmail.com', true),
	(6, 'martin', '8946531651', 'martin@gmail.com', false);


--
-- Name: ak_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ak_seq', 1, false);


--
-- Name: bilgino_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilgino_seq', 1, false);


--
-- Name: bkno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bkno_seq', 1, false);


--
-- Name: dilno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dilno_seq', 1, true);


--
-- Name: ikno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ikno_seq', 1, false);


--
-- Name: istekno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.istekno_seq', 1, false);


--
-- Name: kayitno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kayitno_seq', 1, false);


--
-- Name: kitapno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kitapno_seq', 1, false);


--
-- Name: kno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kno_seq', 1, false);


--
-- Name: ktno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ktno_seq', 1, false);


--
-- Name: uyeno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uyeno_seq', 1, false);


--
-- Name: yazarno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yazarno_seq', 1, false);


--
-- Name: yeno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yeno_seq', 2, true);


--
-- Name: ykno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ykno_seq', 1, false);


--
-- Name: AlinanKitaplar AlinanKitaplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlinanKitaplar"
    ADD CONSTRAINT "AlinanKitaplar_pkey" PRIMARY KEY ("AKNo");


--
-- Name: BagislananKitaplar BagislananKitaplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BagislananKitaplar"
    ADD CONSTRAINT "BagislananKitaplar_pkey" PRIMARY KEY ("BKNo");


--
-- Name: Diller Diller_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diller"
    ADD CONSTRAINT "Diller_pkey" PRIMARY KEY ("DilNo");


--
-- Name: IstenenKitaplar IstenenKitaplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstenenKitaplar"
    ADD CONSTRAINT "IstenenKitaplar_pkey" PRIMARY KEY ("IstekNo");


--
-- Name: Kategoriler Kategoriler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategoriler"
    ADD CONSTRAINT "Kategoriler_pkey" PRIMARY KEY ("KategoriNo");


--
-- Name: KayitTurleri KayitTurleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KayitTurleri"
    ADD CONSTRAINT "KayitTurleri_pkey" PRIMARY KEY ("KayitTurNo");


--
-- Name: Kitaplar Kitaplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "Kitaplar_pkey" PRIMARY KEY ("KitapNo", "ISBN");


--
-- Name: KütüphaneBilgileri KütüphaneBilgileri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KütüphaneBilgileri"
    ADD CONSTRAINT "KütüphaneBilgileri_pkey" PRIMARY KEY ("BilgiNo");


--
-- Name: Ogrenciler Ogrenciler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenciler"
    ADD CONSTRAINT "Ogrenciler_pkey" PRIMARY KEY ("UyeNo");


--
-- Name: Personel Personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_pkey" PRIMARY KEY ("UyeNo");


--
-- Name: Uyeler Uyeler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uyeler"
    ADD CONSTRAINT "Uyeler_pkey" PRIMARY KEY ("UyeNo");


--
-- Name: Yayınevleri Yayınevleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yayınevleri"
    ADD CONSTRAINT "Yayınevleri_pkey" PRIMARY KEY ("PublisherNo");


--
-- Name: YazarKitap YazarKitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarKitap"
    ADD CONSTRAINT "YazarKitap_pkey" PRIMARY KEY ("YKNo");


--
-- Name: Yazarlar Yazarlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazarlar"
    ADD CONSTRAINT "Yazarlar_pkey" PRIMARY KEY ("YazarNo");


--
-- Name: AlinanKitaplar unique_AlinanKitaplar_AKNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlinanKitaplar"
    ADD CONSTRAINT "unique_AlinanKitaplar_AKNo" UNIQUE ("AKNo");


--
-- Name: BagislananKitaplar unique_BagislananKitaplar_BKNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BagislananKitaplar"
    ADD CONSTRAINT "unique_BagislananKitaplar_BKNo" UNIQUE ("BKNo");


--
-- Name: Diller unique_Diller_DilNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diller"
    ADD CONSTRAINT "unique_Diller_DilNo" UNIQUE ("DilNo");


--
-- Name: IstenenKitaplar unique_IstenenKitaplar_IstekNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstenenKitaplar"
    ADD CONSTRAINT "unique_IstenenKitaplar_IstekNo" UNIQUE ("IstekNo");


--
-- Name: IstenenKitaplar unique_IstenenKitaplar_UyeNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstenenKitaplar"
    ADD CONSTRAINT "unique_IstenenKitaplar_UyeNo" UNIQUE ("UyeNo");


--
-- Name: KayitTurleri unique_KayitTurleri_KayitTurNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KayitTurleri"
    ADD CONSTRAINT "unique_KayitTurleri_KayitTurNo" UNIQUE ("KayitTurNo");


--
-- Name: Kitaplar unique_Kitaplar_ISBN; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "unique_Kitaplar_ISBN" UNIQUE ("ISBN");


--
-- Name: Kitaplar unique_Kitaplar_KitapNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "unique_Kitaplar_KitapNo" UNIQUE ("KitapNo");


--
-- Name: KütüphaneBilgileri unique_KütüphaneBilgileri_BilgiNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KütüphaneBilgileri"
    ADD CONSTRAINT "unique_KütüphaneBilgileri_BilgiNo" UNIQUE ("BilgiNo");


--
-- Name: Personel unique_Staff_memberNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "unique_Staff_memberNo" UNIQUE ("UyeNo");


--
-- Name: Ogrenciler unique_Students_memberNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenciler"
    ADD CONSTRAINT "unique_Students_memberNo" UNIQUE ("UyeNo");


--
-- Name: Uyeler unique_Uyeler_UyeNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uyeler"
    ADD CONSTRAINT "unique_Uyeler_UyeNo" UNIQUE ("UyeNo");


--
-- Name: Yayınevleri unique_Yayınevleri_PublisherNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yayınevleri"
    ADD CONSTRAINT "unique_Yayınevleri_PublisherNo" UNIQUE ("PublisherNo");


--
-- Name: YazarKitap unique_YazarKitap_YKNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarKitap"
    ADD CONSTRAINT "unique_YazarKitap_YKNo" UNIQUE ("YKNo");


--
-- Name: Yazarlar unique_Yazarlar_YazarNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazarlar"
    ADD CONSTRAINT "unique_Yazarlar_YazarNo" UNIQUE ("YazarNo");


--
-- Name: index_UyeNo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_UyeNo" ON public."BagislananKitaplar" USING btree ("UyeNo");


--
-- Name: Uyeler kayitKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kayitKontrol" BEFORE INSERT ON public."Uyeler" FOR EACH ROW EXECUTE PROCEDURE public."kayitEkleTR1"();


--
-- Name: Yazarlar yazaradi_degisikligi; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER yazaradi_degisikligi BEFORE UPDATE ON public."Yazarlar" FOR EACH ROW EXECUTE PROCEDURE public.log_yazaradi_degisikligi();


--
-- Name: Kitaplar lnk_AlinanKitaplar_Kitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "lnk_AlinanKitaplar_Kitaplar" FOREIGN KEY ("AlanKullaniciNo") REFERENCES public."AlinanKitaplar"("AKNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kitaplar lnk_Diller_Kitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "lnk_Diller_Kitaplar" FOREIGN KEY ("DilNo") REFERENCES public."Diller"("DilNo") MATCH FULL;


--
-- Name: Kitaplar lnk_Kategoriler_Kitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "lnk_Kategoriler_Kitaplar" FOREIGN KEY ("KategoriNo") REFERENCES public."Kategoriler"("KategoriNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Ogrenciler lnk_KayitTurleri_Ogrenciler; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenciler"
    ADD CONSTRAINT "lnk_KayitTurleri_Ogrenciler" FOREIGN KEY ("KayitTurNo") REFERENCES public."KayitTurleri"("KayitTurNo") MATCH FULL;


--
-- Name: AlinanKitaplar lnk_Kitaplar_AlinanKitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlinanKitaplar"
    ADD CONSTRAINT "lnk_Kitaplar_AlinanKitaplar" FOREIGN KEY ("KitapNo") REFERENCES public."Kitaplar"("KitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BagislananKitaplar lnk_Kitaplar_BagislananKitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BagislananKitaplar"
    ADD CONSTRAINT "lnk_Kitaplar_BagislananKitaplar" FOREIGN KEY ("KitapNo") REFERENCES public."Kitaplar"("KitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: YazarKitap lnk_Kitaplar_YazarKitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarKitap"
    ADD CONSTRAINT "lnk_Kitaplar_YazarKitap" FOREIGN KEY ("KitapNo") REFERENCES public."Kitaplar"("KitapNo") MATCH FULL;


--
-- Name: BagislananKitaplar lnk_Uyeler_BagislananKitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BagislananKitaplar"
    ADD CONSTRAINT "lnk_Uyeler_BagislananKitaplar" FOREIGN KEY ("UyeNo") REFERENCES public."Uyeler"("UyeNo") MATCH FULL;


--
-- Name: IstenenKitaplar lnk_Uyeler_IstenenKitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstenenKitaplar"
    ADD CONSTRAINT "lnk_Uyeler_IstenenKitaplar" FOREIGN KEY ("UyeNo") REFERENCES public."Uyeler"("UyeNo") MATCH FULL;


--
-- Name: Kitaplar lnk_Yayınevleri_Kitaplar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitaplar"
    ADD CONSTRAINT "lnk_Yayınevleri_Kitaplar" FOREIGN KEY ("YayinEviNo") REFERENCES public."Yayınevleri"("PublisherNo") MATCH FULL;


--
-- Name: YazarKitap lnk_Yazarlar_YazarKitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarKitap"
    ADD CONSTRAINT "lnk_Yazarlar_YazarKitap" FOREIGN KEY ("YazarNo") REFERENCES public."Yazarlar"("YazarNo") MATCH FULL;


--
-- PostgreSQL database dump complete
--

