using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RST.Data;
using RST.Models;

namespace RST.API.Controllers;

[ApiController]
[Route("[controller]")]
public class RestaurantController : ControllerBase
{
    private readonly RstContext _context;

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
        // TODO : Implement

        return CreatedAtAction("Get", new {restID = restaurant.restID}, restaurant);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Put(int id, Restaurant restaurant){
        // TODO : Implement

        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id){
        // TODO : Implement

        return NoContent();
    }
}