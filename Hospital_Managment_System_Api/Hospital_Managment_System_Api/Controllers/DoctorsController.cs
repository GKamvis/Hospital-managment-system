using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Numerics;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DoctorsController : ControllerBase
    {

        private readonly HospitalContext _context;

        public DoctorsController(HospitalContext context)
        {
            _context = context;
        }
        // GET: api/Doctors
        [HttpGet]
        public ActionResult<IEnumerable<TableDoctor>> GetDoctors()
        {
            return _context.TableDoctors.ToList();
        }


        // GET api/Doctors/5
        [HttpGet("{id}")]
        public ActionResult<TableDoctor> GetDocorById(int id)
        {
            var doctor = _context.TableDoctors.Find(id);
            if (doctor == null)
            {
                return NotFound();
            }

            _context.SaveChanges();


            return doctor;

        }

        // POST api/Doctors
        [HttpPost]
        public async Task<ActionResult<TableDoctor>> PostDoctor(TableDoctor tableDoctor)
        {
            try
            {
                _context.TableDoctors.Add(tableDoctor);
                await _context.SaveChangesAsync();
                return CreatedAtAction("GetDoctors", new { id = tableDoctor.DoctorId }, tableDoctor);
            }
            catch (DbUpdateException ex)
            {
                // Daxili istisna mesajını log edirik
                var innerExceptionMessage = ex.InnerException?.Message ?? "No inner exception";
                // Daha ətraflı məlumat üçün inner exception məlumatını loglayırıq
                Console.WriteLine($"DbUpdateException error: {innerExceptionMessage}");
                // Bad request cavabında inner exception məlumatını qaytarırıq
                return BadRequest(new { error = innerExceptionMessage });
            }
        }


        // PUT api/Doctors/5
        [HttpPut("{id}")]
        public ActionResult<TableDoctor> PutDoctor(int id, TableDoctor tableDoctor)
        {

            var doctor = _context.TableDoctors.Find(id);

            if (doctor == null)
            {
                return NotFound();
            }
            _context.Update(tableDoctor);
            _context.SaveChanges();

            return NoContent();
        }


        // DELETE api/Doctors/5
        [HttpDelete("{id}")]
        public ActionResult<TableDoctor> DeleteDoctor(int id)
        {
            var doctor = _context.TableDoctors.Find(id);

            if (doctor == null)
            {
                return NotFound();
            }

            _context.TableDoctors.Remove(doctor);
            _context.SaveChanges();

            return doctor;

        }
    }
}
