/*using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {

        private readonly HospitalContext _context;

        public PaymentController(HospitalContext context)
        {
            _context = context;

        }



        // GET: api/PatientController/5
        [HttpGet("{id}")]
        public ActionResult GetAnalysisPriceForPatient(int id)
        {
            var patient = _context.TablePatients.FirstOrDefault(p => p.PatientId == id);
            if (patient == null)
            {
                return NotFound(new { message = "Patient not found." });
            }

            var analysis = _context.TableAnalyses.FirstOrDefault(a => a.AnalysisId == patient.AnalysisId);
            if (analysis == null)
            {
                return NotFound(new { message = "Analysis not found for this patient." });
            }

            return Ok(new { Patient_Name = patient.PatientName, Analysis_Price = analysis.AnalysisPrice });


        }
    }
}
*/