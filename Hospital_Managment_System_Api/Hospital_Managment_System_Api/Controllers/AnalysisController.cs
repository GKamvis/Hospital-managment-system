/*using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnalysisController : ControllerBase
    {

        private readonly HospitalContext _context;


        public AnalysisController(HospitalContext context)
        {
            _context = context;
        }

        // Get :api/<AnalysisController>

        [HttpGet]

        public ActionResult<IEnumerable<TableAnalysis>> GetAnalysis()
        {
            return _context.TableAnalyses.ToList();
        }


        // Post :api/<AnalysisController>

        [HttpPost]

        public IActionResult PostAnalysis(TableAnalysis tableAnalysis)
        {
            _context.TableAnalyses.Add(tableAnalysis);
            _context.SaveChanges();
            return CreatedAtAction("GetAnalysis", new { tableAnalysis });
        }


        public class PatientAnalysisViewModel
        {
            public int PatientId { get; set; }
            public int AnalysisId { get; set; }
        }




        [HttpPost]
        public IActionResult PutAnalysis(int id, PatientAnalysisViewModel model)
        {
            var tablePatient = new TablePatient
            {
                PatientId = model.PatientId,
                AnalysisId = model.AnalysisId
            };

            _context.TablePatients.Add(tablePatient);
            _context.SaveChanges();

            return CreatedAtAction("GetPatients", new { id = tablePatient.PatientId }, tablePatient);

        }
    }
}
*/