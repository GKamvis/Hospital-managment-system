using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NursesController : ControllerBase
    {

        private readonly HospitalContext _context;

        public NursesController(HospitalContext context)
        {
            _context = context;
        }
        // GET: api/Nurse
        [HttpGet]
        public ActionResult<IEnumerable<TableNurse>> GetNurses()
        {
            return _context.TableNurses.ToList();
        }


        // GET api/Nurse/5
        [HttpGet("{id}")]
        public ActionResult<TableNurse> GetNurseById(int id)
        {
            var doctor = _context.TableNurses.Find(id);
            if (doctor == null)
            {
                return NotFound();
            }

            _context.SaveChanges();


            return doctor;

        }

        // POST api/Nurse
        [HttpPost]
        public async Task<ActionResult<TableNurse>> PostPatient(TableNurse tableNurse)
        {
            try
            {
                _context.TableNurses.Add(tableNurse);
                await _context.SaveChangesAsync();
                return CreatedAtAction("GetNurses", new { tableNurse });
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

        // DELETE api/Nurse/5
        [HttpDelete("{id}")]
        public ActionResult<TableNurse> DeleteNurses(int id)
        {
            var doctor = _context.TableNurses.Find(id);

            if (doctor == null)
            {
                return NotFound();
            }

            _context.TableNurses.Remove(doctor);
            _context.SaveChanges();

            return doctor;

        }
    }
}


