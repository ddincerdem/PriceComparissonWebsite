using MiniWave.Model;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MiniWave.Controllers
{
    [Authorize]
    public class UrunController : Controller
    {
        

        Miniwave db = new Miniwave();

        // GET: Urun
        public ActionResult Index(string searching)
        {
            ViewData["mesaj"] = "Tüm Ürünler";
            int adet = db.URUN.Where(x => x.UrunAdi.Contains(searching) || searching == null).Count();
            ViewData["adet"] = adet.ToString();
            return View(db.URUN.Where(x=>x.UrunAdi.Contains(searching) || searching == null).ToList());
        }
        public ActionResult Kategori(int id)
        {
            var urun = db.KategoridekiUrunler(id).ToList();
            ViewData["mesaj"] = "Ürünler";
            return View(urun);
        }
        [Authorize(Roles ="Kullanıcı")]
        public ActionResult FavoriEkle(int id)
        {
            URUN urun = db.URUN.FirstOrDefault(x => x.UrunID == id);
            FAVORİLER fav = new FAVORİLER();
            var user = db.USERS.FirstOrDefault(z => z.UserNick == User.Identity.Name);
            fav.FavoriUrunID = urun.UrunID;
            fav.FavoriUrunSahibiID = user.UserID;
            db.FAVORİLER.Add(fav);
            db.SaveChanges();

            return RedirectToAction("Index");

        }
        [Authorize(Roles ="Admin")]

        public ActionResult UrunEkle()
        {
            List<SelectListItem> degerlerKat = (from i in db.ALT_KATEGORİ.ToList()
                                                select new SelectListItem
                                                {
                                                    Text = i.AltKategoriAdi,
                                                    Value = i.AltKategoriID.ToString()
                                                }
                                                ).ToList();
            List<SelectListItem> degerlerMag = (from i in db.MAGAZA.ToList()
                                                select new SelectListItem
                                                {
                                                    Text = i.MagazaAdi,
                                                    Value = i.MagazaID.ToString()
                                                }
                                    ).ToList();

            ViewBag.kategoriler = degerlerKat;
            ViewBag.magaza = degerlerMag;
            return View();
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult UrunEkle(URUN a)
        {
            if (Request.Files.Count > 0)
            {
                string dosyaadi = Path.GetFileName(Request.Files[0].FileName) + DateTime.Now.ToString("yymmssfff");
                string uzanti = Path.GetExtension(Request.Files[0].FileName);
                string yol = "~/Image/" + dosyaadi + uzanti;
                Request.Files[0].SaveAs(Server.MapPath(yol));
                a.UrunResimPath = "/Image/" + dosyaadi + uzanti; 

            }
            //*****************************************************************************
            var magaza = db.MAGAZA.Where(m => m.MagazaID == a.MAGAZA.MagazaID).FirstOrDefault();
            a.MAGAZA = magaza;
            var kate = db.ALT_KATEGORİ.Where(m => m.AltKategoriID == a.ALT_KATEGORİ.AltKategoriID).FirstOrDefault();
            a.ALT_KATEGORİ = kate;
            db.URUN.Add(a);
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        public ActionResult EnDusukFiyat()
        {
            var urun = db.TumUrunleriEnDusukFiyataGoreSirala().ToList();
            ViewData["mesaj"] = "Tüm Ürünler";
            int adet = db.URUN.Count();
            ViewData["adet"] = adet.ToString();

            return View(urun);
        }
        public ActionResult EnYuksekFiyat()
        {
            var urun = db.TumUrunleriEnYuksekFiyataGoreSirala().ToList();
            ViewData["mesaj"] = "Tüm Ürünler";
            int adet = db.URUN.Count();
            ViewData["adet"] = adet.ToString();

            return View(urun);
        }
        public ActionResult EnYeniUrunler()
        {
            var urun = db.TumUrunlerdeEnYeniUrunler().ToList();
            ViewData["mesaj"] = "En Son Eklenen Ürünler";
            int adet = db.TumUrunlerdeEnYeniUrunler().Count();
            ViewData["adet"] = adet.ToString();

            return View(urun);
        }
        [Authorize(Roles = "Admin")]
        public ActionResult UrunSil(int id)
        {
            URUN urun = db.URUN.FirstOrDefault(x => x.UrunID == id);
            return View(urun);
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult UrunSil(URUN u)
        {
            URUN urun = db.URUN.FirstOrDefault(x => x.UrunID == u.UrunID);
            db.URUN.Remove(urun);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        [Authorize(Roles = "Admin")]
        public ActionResult UrunDuzenle(int id)
        {
            URUN urun = db.URUN.FirstOrDefault(x => x.UrunID == id);

            List<SelectListItem> degerlerKat = (from i in db.ALT_KATEGORİ.ToList()
                                                select new SelectListItem
                                                {
                                                    Text = i.AltKategoriAdi,
                                                    Value = i.AltKategoriID.ToString()
                                                }
                                    ).ToList();
            List<SelectListItem> degerlerMag = (from i in db.MAGAZA.ToList()
                                                select new SelectListItem
                                                {
                                                    Text = i.MagazaAdi,
                                                    Value = i.MagazaID.ToString()
                                                }
                                    ).ToList();

            ViewBag.kategoriler = degerlerKat;
            ViewBag.magaza = degerlerMag;

            return View(urun);
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult UrunDuzenle(URUN u)
        {
            if (Request.Files.Count > 0)
            {
                string dosyaadi = Path.GetFileName(Request.Files[0].FileName) + DateTime.Now.ToString("yymmssfff");
                string uzanti = Path.GetExtension(Request.Files[0].FileName);
                string yol = "~/Image/" + dosyaadi + uzanti;
                Request.Files[0].SaveAs(Server.MapPath(yol));
                u.UrunResimPath = "/Image/" + dosyaadi + uzanti;

            }
            //**********************************************************************
            URUN urun = db.URUN.FirstOrDefault(x => x.UrunID == u.UrunID);

            urun.UrunAdi = u.UrunAdi;
            urun.UrunAciklama = u.UrunAciklama;
            urun.UrunFiyat = u.UrunFiyat;
            var magaza = db.MAGAZA.Where(m => m.MagazaID == u.MAGAZA.MagazaID).FirstOrDefault();
            u.MAGAZA = magaza;
            var kategori = db.ALT_KATEGORİ.Where(m => m.AltKategoriID == u.ALT_KATEGORİ.AltKategoriID).FirstOrDefault();
            u.ALT_KATEGORİ = kategori;
            urun.UrunKategoriID = kategori.AltKategoriID;
            urun.UrunMagazaID = magaza.MagazaID;
            urun.UrunResimPath = u.UrunResimPath;

            db.SaveChanges();

            return RedirectToAction("Index");
        }

    }
}
