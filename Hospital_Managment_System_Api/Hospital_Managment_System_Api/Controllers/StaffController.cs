using Hospital_Managment_System_Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Hospital_Managment_System_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StaffController : ControllerBase
    {

        private readonly HospitalContext _context;

        public StaffController(HospitalContext context)
        {
            _context = context;
        }
        // GET: api/<StaffController>
        [HttpGet]
        public ActionResult<IEnumerable<TableStaff>> GetStaff()
        {
            return _context.TableStaffs.ToList();
        }


        // GET api/<StaffController>/5
        [HttpGet("{id}")]
        public ActionResult<TableStaff> GetStaffById(int id)
        {
            var staff = _context.TableStaffs.Find(id);
            if (staff == null)
            {
                return NotFound();
            }

            _context.SaveChanges();


            return staff;

        }

        // POST api/<StaffController>
        [HttpPost]
        public ActionResult<TableStaff> PostStaff(TableStaff tableStaff)
        {
            _context.TableStaffs.Add(tableStaff);
            _context.SaveChanges();
            return CreatedAtAction("GetDoctors", new { tableStaff });
        }

        // DELETE api/<StaffController>/5
        [HttpDelete("{id}")]
        public ActionResult<TableStaff> DeleteStaff(int id)
        {
            var staff = _context.TableStaffs.Find(id);

            if (staff == null)
            {
                return NotFound();
            }

            _context.TableStaffs.Remove(staff);
            _context.SaveChanges();

            return staff;

        }
    }
}
