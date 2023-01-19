using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RST.Data;
using RST.Models;

namespace RST.API.Controllers;

[ApiController]
[Route("[controller]")]
public class RestaurantController : ControllerBase
{
    private readonly IRstContext _context;
    private readonly char[] grades = {'A', 'B', 'C', 'D'};

    public RestaurantController(RstContext context){
        this._context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Restaurant>>> Get() {
        return await _context.Restaurants.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Restaurant>> Get(int id) {
        var restaurant = await _context.Restaurants.FindAsync(id);

        if (restaurant is null) return NotFound();

        return restaurant;
    }

    [HttpPost]
    public async Task<ActionResult<Restaurant>> Post(Restaurant restaurant){
        restaurant.restID = null;
        restaurant.grade = Char.ToUpper((char)restaurant.grade!);
        //Only constraint is that grade is A, B, C, or D
        if (!grades.Any(g => g==restaurant.grade)) 
            return BadRequest("Grade must be 'A', 'B', 'C', or 'D'");
        await _context.Restaurants.AddAsync(restaurant);
        await (_context as RstContext)!.SaveChangesAsync();

        return CreatedAtAction("Get", new {restID = restaurant.restID}, restaurant);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Put(int id, Restaurant restaurant)
    {
        //if id and restaurant's id don't match, return badrequest
        if (id != restaurant.restID)
            return BadRequest("ID does not match the Restaurant");
        //if the Restaurant is not in the Context, return NotFound
        if (!await RestaurantExists(restaurant.restID))
            return NotFound("Restaurant not found");

        (_context as RstContext)!.Entry(restaurant).State = EntityState.Modified;
        await (_context as RstContext)!.SaveChangesAsync();

        return NoContent();
    }

    [HttpDelete("{restaurant.restID}")]
    public async Task<IActionResult> Delete(Restaurant restaurant){
        if (!await RestaurantExists(restaurant.restID))
            return NotFound("Restaurant does not exist");

        _context.Restaurants.Remove(restaurant);
        await (_context as RstContext)!.SaveChangesAsync();

        return NoContent();
    }

    private async Task<bool> RestaurantExists(int? rid) {
        return await _context.Restaurants.AnyAsync(r => r.restID == rid);
    }
}