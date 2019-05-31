using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PassengersApi.Models;

namespace PassengersApi.Controllers
{
    [Route("people")]
    [ApiController]
    public class PassengersController : ControllerBase
    {
        private readonly PassengersContext _context;

        public PassengersController(PassengersContext context)
        {
            _context = context;
        }

        // GET: people
        /// <summary>
        /// list all passengers
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Passenger>>> GetPassenger()
        {
            return await _context.Passengers.ToListAsync();
        }

        // GET: people/5
        /// <summary>
        /// Get a specific passenger
        /// </summary>
        /// <param name="id"></param>  
        [HttpGet("{id}")]
        public async Task<ActionResult<Passenger>> GetPassenger(int id)
        {
            var passenger = await _context.Passengers.FindAsync(id);

            if (passenger == null)
            {
                return NotFound();
            }

            return passenger;
        }

        // PUT: people/5
        /// <summary>
        /// Modify a specific passenger
        /// </summary>
        /// <param name="id"></param>  
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPassenger(int id, Passenger passenger)
        {
            if (id != passenger.Id)
            {
                return BadRequest();
            }

            _context.Entry(passenger).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PassengerExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: people
        /// <summary>
        /// Add a new passenger
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<Passenger>> PostPassenger(Passenger passenger)
        {
            _context.Passengers.Add(passenger);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPassenger", new { id = passenger.Id }, passenger);
        }

        // DELETE: people/5
        /// <summary>
        /// Deletes a specific passenger
        /// </summary>
        /// <param name="id"></param>  
        [HttpDelete("{id}")]
        public async Task<ActionResult<Passenger>> DeletePassenger(int id)
        {
            var passenger = await _context.Passengers.FindAsync(id);
            if (passenger == null)
            {
                return NotFound();
            }

            _context.Passengers.Remove(passenger);
            await _context.SaveChangesAsync();

            return passenger;
        }

        private bool PassengerExists(int id)
        {
            return _context.Passengers.Any(e => e.Id == id);
        }
    }
}
