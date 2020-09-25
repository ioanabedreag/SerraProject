using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace FarmApi.Controllers
{
    public class WorkerController: ApiController
    {
        private FarmEntities _context;

        public IHttpActionResult GetAllWorkers()
        {
            _context = new FarmEntities();
            try
            {
                dynamic workers = _context.GetAllWorkers().ToList();
                return Ok(workers);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult AddWorker([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String workername = client["WorkerName"];
                _context.AddWorker(workername);
                return Ok("Worker added successfully!");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult AddHarvestedQuantityByWorker([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String username = client["Username"];
                String workername = client["WorkerName"];
                double quantity = client["Quantity"];
                _context.AddHarvestedQuantityByWorker(quantity, username, workername);
                return Ok("Harvested quantity by worker added successfully!");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetQuantitiesByWorker(string workername)
        {
            _context = new FarmEntities();
            try
            {
                var quantities = _context.GetQuantitiesByWorker(workername);
                return Ok(quantities);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetQuantitiesByPlantation(string username)
        {
            _context = new FarmEntities();
            try
            {
                var quantity = _context.GetQuantitiesByPlantation(username);
                return Ok(quantity);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult DeleteWorker(string workername)
        {
            _context = new FarmEntities();
            try
            {
                _context.DeleteWorker(workername);
                return Ok("Deleted");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}