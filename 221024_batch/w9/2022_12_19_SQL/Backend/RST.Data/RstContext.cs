using Microsoft.EntityFrameworkCore;
using System.Transactions;
using RST.Models;

namespace RST.Data;

public class RstContext : DbContext, IRstContext
{
    public RstContext (DbContextOptions<RstContext> options)
        : base(options) {}

    public DbSet<Restaurant> Restaurants {get;set;} = null!;
    public DbSet<Cuisine> Cuisines {get;set;} = null!;
    public DbSet<MenuItem> MenuItems {get;set;} = null!;
    public DbSet<Score> Scores {get;set;} = null!;

    protected override void OnModelCreating(ModelBuilder modelbuilder){
        modelbuilder.Entity<Restaurant>(entity =>
            { entity.ToTable("Restaurant", "RST");});
        modelbuilder.Entity<Cuisine>(entity =>
            { entity.ToTable("Cuisine", "RST");});
        modelbuilder.Entity<MenuItem>(entity =>
            { entity.ToTable("MenuItems", "RST");});
        modelbuilder.Entity<Score>(entity =>
            { entity.ToTable("Score", "RST");});
        
    }
}