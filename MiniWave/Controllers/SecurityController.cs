using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using MiniWave.Model;

namespace MiniWave.Controllers
{
    public class SecurityController : Controller
    {
        Miniwave db = new Miniwave();
        [AllowAnonymous]
        // GET: Security
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [AllowAnonymous]

        public ActionResult Login(USERS k)
        {
            var user = db.USERS.FirstOrDefault(x => x.UserNick == k.UserNick && x.UserPassword == k.UserPassword);
            if (user != null)
            {
                FormsAuthentication.SetAuthCookie(k.UserNick, false);
                return RedirectToAction("Index", "Urun");
            }
            else
            {
                ViewBag.Message = "Nickiniz ya da Şifreniz Hatalı";
                return View();
            }
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return View("Login");
        }

        public ActionResult Register()
        {

            return View();
        }

        [HttpPost]
        public ActionResult Register(USERS user)
        {
            if (ModelState.IsValid)
            {

                var check = db.USERS.FirstOrDefault(s => s.UserNick == user.UserNick);
                if (check==null)
                {
                    user.UserRole = 1;
                    db.USERS.Add(user);
                    db.SaveChanges();
                }
                else
                {
                    ViewBag.error = "Bu kullanıcı ismi kullanılmaktadır";
                    return View();
                }

            }
            return RedirectToAction("Login"); 

        }
    }
}