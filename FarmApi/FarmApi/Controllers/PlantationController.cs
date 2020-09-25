using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace FarmApi.Controllers
{
    public class PlantationController :ApiController
    {
        private FarmEntities _context;

        public IHttpActionResult GetAllPlantation()
        {
            _context = new FarmEntities();
            try
            {
                dynamic plantations = _context.GetAllPlantations().ToList();
                return Ok(plantations);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetQuantitiesByPlantation()
        {
            _context = new FarmEntities();
            try
            {
                var quantity = _context.GetQuantitiesByPlantation();
                return Ok(quantity);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult AddPlantation([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String harvest = client["Harvest"];
                
                _context.AddPlantation(harvest, 0);
                return Ok("Plantation added successfully!");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult DeletePlantation(int plantationID)
        {
            _context = new FarmEntities();
            try
            {
                _context.DeletePlantation(plantationID);
                return Ok("Deleted");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetPlantationByUser(string username)
        {
            _context = new FarmEntities();
            try
            {
                var plantation = _context.GetPlantationByUser(username).FirstOrDefault();
                return Ok(plantation);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}