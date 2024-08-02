using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientController : ControllerBase
    {
        private readonly HospitalContext _context;

        public PatientController(HospitalContext context)
        {
            _context = context;
            
        }

        // GET: api/Patient

        [HttpGet]

        public ActionResult<IEnumerable<TablePatient>> GetPatients()
        {
            return _context.TablePatients.ToList();
        }



        // Post: api/Patient
        [HttpPost]


        public async Task<ActionResult<TablePatient>> PostPatient(TablePatient tablePatient)
        {
        
            try
            {
                _context.TablePatients.Add(tablePatient);
                await _context.SaveChangesAsync();
                return CreatedAtAction("GetPatients", new { tablePatient });

            }
            catch (DbUpdateException ex)
            {
                var innerExceptionMessage = ex.InnerException?.Message ?? "No inner exception";
                // Daha ətraflı məlumat üçün inner exception məlumatını loglayırıq
                Console.WriteLine($"DbUpdateException error: {innerExceptionMessage}");
                // Bad request cavabında inner exception məlumatını qaytarırıq
                return BadRequest(new { error = innerExceptionMessage });
            }






        }

        /*        // Post: api/Patient

                [HttpPost]
                public IActionResult PostPatientAnalysis(PatientAnalysisViewModel model)
                {
                    var tablePatient = new TablePatient
                    {
                        PatientId = model.PatientId,
                        AnalysisId = model.AnalysisId
                    };

                    _context.TablePatients.Add(tablePatient);
                    _context.SaveChanges();

                    return CreatedAtAction("GetPatients", new { id = tablePatient.PatientId }, tablePatient);
                }*/




        // GET api/Patient/5
        [HttpGet("{id}")]

        public ActionResult<TablePatient> GetPatientById(int id)
        {
            var patient = _context.TablePatients.Find(id);

            if(patient == null)
            {
                return NotFound();
            }
            _context.SaveChanges();

            return patient;
        }


        // Delete api/Patient/5
        [HttpDelete("{id}")]

        public ActionResult<TablePatient> DeletePatient(int id)
        {
            var patient = _context.TablePatients.Find(id);
            if(patient== null)
            {
                return NotFound();
            }

            _context.TablePatients.Remove(patient);

            _context.SaveChanges();

            return patient;

        }


    }
}
