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

        public IHttpActionResult GetQuantitiesByWorker([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String qRCode = client["QRCode"];
                var quantities = _context.GetQuantitiesByWorker(qRCode);
                return Ok(quantities);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public IHttpActionResult GetTotalQuantityByWorker([FromBody] dynamic client)
        {
            _context = new FarmEntities();
            try
            {
                String qRCode = client["QRCode"];
                var quantity = _context.GetTotalQuantityByWorker(qRCode);
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