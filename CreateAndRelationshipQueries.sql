CREATE TABLE USERS 
(
    UserID int IDENTITY(1, 1) primary key not null,
    UserNick nvarchar(50) not null,
	UserName nvarchar(50) not null,
	UserPassword nvarchar(50) not null,
	UserRole int not null
)

CREATE TABLE ROLES 
(
    RolID int IDENTITY(1, 1) primary key not null,
	RolName nvarchar(50) not null
)


ALTER TABLE USERS 
ADD FOREIGN KEY(UserRole) REFERENCES ROLES(RolID)

CREATE TABLE KATEGORÝ
(
    KategoriID int IDENTITY(1, 1) primary key not null,
	KategoriAdý nvarchar(50),
)

CREATE TABLE ALT_KATEGORÝ
(
    AltKategoriID int IDENTITY(1, 1) primary key not null,
	AltKategoriAdi nvarchar(50),
	AnaKategoriID int,
)

ALTER TABLE ALT_KATEGORÝ 
ADD FOREIGN KEY(AnaKategoriID) REFERENCES Kategori(KategoriID) 

CREATE TABLE URUN
(
    UrunID int IDENTITY(1, 1) primary key not null, 
    UrunAdi nvarchar(50), 
	UrunResimPath nvarchar(MAX),
	UrunAciklama nvarchar(MAX),
	UrunMagazaID int not null,
)

ALTER TABLE URUN
ADD UrunKategoriID int

ALTER TABLE URUN
ADD UrunFiyat int

 ALTER TABLE URUN
 ADD FOREIGN KEY (UrunKategoriID) REFERENCES ALT_KATEGORÝ(AltKategoriID)

CREATE TABLE MAGAZA 
(
    MagazaID int IDENTITY(1, 1) primary key not null,
	MagazaAdi nvarchar(50),
	MagazaResimPath nvarchar(MAX),
)

ALTER TABLE URUN 
ADD FOREIGN KEY (UrunMagazaID) REFERENCES MAGAZA(MagazaID)


CREATE TABLE FAVORÝLER
(
   FavoriID int IDENTITY(1, 1) primary key not null,
   FavoriUrunID int,
   FavoriUrunSahibiID int
)

ALTER TABLE FAVORÝLER 
ADD FOREIGN KEY (FavoriUrunID) REFERENCES URUN(UrunID) ON DELETE CASCADE

ALTER TABLE FAVORÝLER
ADD FOREIGN KEY (FavoriUrunSahibiID) REFERENCES USERS(UserID) ON DELETE CASCADE

DROP TABLE FAVORÝLER

