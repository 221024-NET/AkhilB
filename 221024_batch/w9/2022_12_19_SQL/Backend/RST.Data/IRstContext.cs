using RST.Models;
using Microsoft.EntityFrameworkCore;

namespace RST.Data;

public interface IRstContext : IDisposable
{
    DbSet<Restaurant> Restaurants {get;}
    DbSet<Cuisine> Cuisines {get;}
    DbSet<MenuItem> MenuItems {get;}
    DbSet<Score> Scores {get;}
    int SaveChanges();
}