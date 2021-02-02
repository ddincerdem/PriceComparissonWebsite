using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MiniWave.Model;

namespace MiniWave.Controllers
{
    [Authorize] 
    public class FavoriController : Controller
    { 
        Miniwave db = new Miniwave();

        // GET: Favori
        public ActionResult Index()
        {
            var user = db.USERS.FirstOrDefault(z => z.UserNick == User.Identity.Name);
            var a = db.FavoriGoruntule(user.UserID);
            return View(a);
        }

        public ActionResult Sil ()
        {

            return View("Favoriler");
        }
    }
    
}