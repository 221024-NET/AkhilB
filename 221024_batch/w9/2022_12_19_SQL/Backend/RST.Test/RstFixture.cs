
using Microsoft.EntityFrameworkCore;

namespace RST.Test;

public class RstFixture : IDisposable
{
    public RstContext Context {get;set;}

    public RstFixture() {
        var options = new DbContextOptionsBuilder<RstContext>()
            .UseInMemoryDatabase("RstDb")
            .Options;
        Context = new RstContext(options);

        //Seed with one or two items in the DbSets
        Context.Restaurants.Add(new Restaurant{restID=1, rName="Name1", rAddress="Address1", rCity="City1",rState="State1",grade='A'});

        Context.Cuisines.Add(new Cuisine{cuisID=1, cuisName="Cuisine1", restID=1});

        Context.MenuItems.Add(new MenuItem{itemID=1, itemName="Item1", itemDescription="Desc1", restID=1, price=50});

        Context.Scores.Add(new Score{refID=1, restID=1, points=90, reviewdate=DateTime.Today});

        Context.SaveChanges();
    }

    public void Dispose()
    {
        Context.Dispose();
    }
}