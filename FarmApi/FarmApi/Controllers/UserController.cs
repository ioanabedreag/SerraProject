using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace FarmApi.Controllers
{
    public class UserController : ApiController
    {
        private FarmEntities _context;

        public IHttpActionResult GetAllUsers()
        {
            _context = new FarmEntities();
            try
            {
                dynamic users = _context.GetAllUsers().ToList();
                return Ok(users);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }        
        
        public IHttpActionResult AddUser([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String username = client["Username"];
                String password = client["Password"];
                String name = client["Name"];
                String address = client["Address"];
                String cnp = client["CNP"];
                String email = client["Email"];
                _context.AddUser(username, password, name, cnp, address, email, 0);
                return Ok("User added successfully!");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult DeleteUser(string username)
        {
            _context = new FarmEntities();
            try
            {
                _context.DeleteUser(username);
                return Ok("Deleted");
            }
            catch (Exception ex)
            {
                return InternalServerError();
            }
        }

        //public IHttpActionResult GetUserByUsername(String username)
        //{
        //    _context = new FarmEntities();
        //    try
        //    {
        //        //var user = _context.GetUserByUsername(username).FirstOrDefault();
        //        //return Ok(user);
        //    }
        //    catch (Exception ex)
        //    {
        //        return InternalServerError(ex);
        //    }
        //}
    }
}