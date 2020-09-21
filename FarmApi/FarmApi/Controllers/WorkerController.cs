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
                String name = client["Username"];
                String qRCode = client["QRCode"];
                _context.AddWorker(name, qRCode);
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
                String name = client["Username"];
                String qRCode = client["QRCode"];
                float quantity = client["Quantity"];
                _context.AddHarvestedQuantityByWorker(qRCode, quantity, name);
                return Ok("Harvested quantity by worker added successfully!");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetQuantitiesByWorker(string qrCode)
        {
            _context = new FarmEntities();
            try
            {
                var quantities = _context.GetQuantitiesByWorker(qrCode);
                return Ok(quantities);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetTotalQuantityByWorker(string qrCode)
        {
            _context = new FarmEntities();
            try
            {
                var quantity = _context.GetTotalQuantityByWorker(qrCode);
                return Ok(quantity);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult DeleteWorker(string qrCode)
        {
            _context = new FarmEntities();
            try
            {
                _context.DeleteWorker(qrCode);
                return Ok("Deleted");
            }
            catch (Exception ex)
            {
                return InternalServerError();
            }
        }
    }
}