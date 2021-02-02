--EN DÜÞÜK FÝYATA GÖRE SIRALAMA

  CREATE PROCEDURE TumUrunleriEnDusukFiyataGoreSirala
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID
  ORDER BY URUN.UrunFiyat ASC
  GO

  CREATE PROCEDURE KategoridekiUrunleriEnDusukFiyataGoreSirala @Kategori int
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID 
  WHERE URUN.UrunKategoriID = @Kategori
  ORDER BY URUN.UrunFiyat ASC
  GO;

  --EN YÜKSEK FÝYATA GÖRE SIRALAMA
  
  CREATE PROCEDURE TumUrunleriEnYuksekFiyataGoreSirala
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID
  ORDER BY URUN.UrunFiyat DESC
  GO;

  CREATE PROCEDURE KategoridekiUrunleriEnYuksekFiyataGoreSirala @Kategori int
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori ,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID 
  WHERE URUN.UrunKategoriID = @Kategori
  ORDER BY URUN.UrunFiyat DESC
  GO;

  -- EN YENÝ ÜRÜNLER 

  CREATE  PROCEDURE TumUrunlerdeEnYeniUrunler 
  AS
  SELECT TOP 5 URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID
  GO;
  
 
  CREATE  PROCEDURE KategoridekiUrunlerdeEnYeniUrunler @Kategori int
  AS
  SELECT TOP 5 URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID
  WHERE URUN.UrunKategoriID = @Kategori
  GO;

  --TOPLAM URUN SAYÝSÝ 

  CREATE PROCEDURE TumUrunlerinSayisi @Sayi int output
  AS
  SELECT  @Sayi = COUNT(UrunID) FROM URUN
  GO;

  CREATE PROCEDURE KategorideUrunSayisi @Kategori int, @Sayi int output
  AS
  SELECT  @Sayi = COUNT(UrunID) FROM URUN
  WHERE URUN.UrunKategoriID = @Kategori
  GO;


  --URUN GORUNTULEME (Dene Bunu)

  CREATE VIEW [TumUrunler] 
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID;

  SELECT * FROM [TumUrunler];

  --KATEGORÝDEKÝ URUNLERÝ GÖSTERMEK 

  CREATE PROCEDURE  KategoridekiUrunler @Kategori int
  AS
  SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori, URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID 
  WHERE URUN.UrunKategoriID = @Kategori
  GO

  --SELECT * FROM KategoridekiUrunler(2)

  --FAVORÝLER 

  CREATE PROCEDURE FavoriGoruntule @UserID int
  AS
  SELECT URUN.UrunAdi,URUN.UrunResimPath FROM (FAVORÝLER 
  LEFT JOIN USERS ON USERS.UserID = FAVORÝLER.FavoriUrunSahibiID)
  LEFT JOIN URUN ON URUN.UrunID = FAVORÝLER.FavoriUrunID
  WHERE USERS.UserID = @UserID
  GO;

  --EN POPÜLER URUN

  CREATE PROCEDURE EnPopulerUrunuBul
  AS
  SELECT URUN.UrunAdi, COUNT(UrunID) as ToplamFav FROM (FAVORÝLER 
  LEFT JOIN USERS ON USERS.UserID = FAVORÝLER.FavoriUrunSahibiID)
  LEFT JOIN URUN ON URUN.UrunID = FAVORÝLER.FavoriUrunID
  GROUP BY UrunAdi
  ORDER BY ToplamFav DESC
  GO;

  CREATE PROCEDURE KategorideEnPopulerUrunuBul @Kategori int
  AS  
  SELECT URUN.UrunAdi, COUNT(UrunID) as ToplamFav FROM (FAVORÝLER 
  LEFT JOIN USERS ON USERS.UserID = FAVORÝLER.FavoriUrunSahibiID)
  LEFT JOIN URUN ON URUN.UrunID = FAVORÝLER.FavoriUrunID
  WHERE URUN.UrunKategoriID = @Kategori
  GROUP BY UrunAdi
  ORDER BY ToplamFav DESC
  GO;


  --URUN EKLEME 

  CREATE PROCEDURE UrunEkle
	   @UrunAdi nvarchar(50),
	   @UrunResimPath nvarchar(50),
	   @UrunAciklama nvarchar(50),
	   @UrunMagaza int,
	   @UrunKategori int,
	   @UrunFiyat int
  AS
  BEGIN
    INSERT INTO [URUN]
	VALUES
	     (
		   @UrunAdi,
		   @UrunResimPath,
		   @UrunAciklama,
		   @UrunMagaza,
		   @UrunKategori,
		   @UrunFiyat
		 )
  END
  GO;
        
--URUN SÝLME

  CREATE PROCEDURE UrunSil @UrunID int
  AS
  BEGIN
  DELETE FROM URUN WHERE URUN.UrunID = @UrunID
  END
  GO;

  --ÜRÜN ARAMA

  CREATE PROCEDURE UrunArama @UrunAdi nvarchar(50)
  AS
  BEGIN
    SELECT URUN.UrunAdi,URUN.UrunAciklama,URUN.UrunFiyat,MAGAZA.MagazaAdi,ALT_KATEGORÝ.AltKategoriAdi as Kategori,URUN.UrunResimPath FROM (URUN 
  LEFT JOIN MAGAZA ON URUN.UrunMagazaID = MAGAZA.MagazaID) 
  LEFT JOIN ALT_KATEGORÝ ON  ALT_KATEGORÝ.AltKategoriID = URUN.UrunKategoriID WHERE URUN.UrunAdi LIKE '%'+@UrunAdi+'%'
  END
  GO





