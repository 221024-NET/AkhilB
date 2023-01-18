
using Microsoft.EntityFrameworkCore;
using Moq;
using RST.Data;
using RST.Models;

namespace RST.Test;

public class RstFixture
{
    public Mock<RstContext> Context {get;set;}

    public RstFixture() {
        Context = new Mock<RstContext>();
        //seed a restaurant or two
        var restaurants = new List<Restaurant>()
        {
            new Restaurant {restID = 1, rName = "McDonald's", rAddress="10701 Narcoossee Rd", rCity="Orlando", rState="Florida", grade='B'}
            //
        };
        //First have to mock the Restaurants DbSet and do any setup since we have a populated list already 
        var mockRestaurantSet = new Mock<DbSet<Restaurant>>();
        mockRestaurantSet.As<IQueryable<Restaurant>>().Setup(m => 
            m.Provider).Returns(restaurants.AsQueryable().Provider);
        mockRestaurantSet.As<IQueryable<Restaurant>>().Setup(m => 
            m.Expression).Returns(restaurants.AsQueryable().Expression);
        mockRestaurantSet.As<IQueryable<Restaurant>>().Setup(m => 
            m.ElementType).Returns(restaurants.AsQueryable().ElementType);
        mockRestaurantSet.As<IQueryable<Restaurant>>().Setup(m => 
            m.GetEnumerator()).Returns(restaurants.AsQueryable().GetEnumerator());
        //Now to setup the context itself to return the DbSet
        Context.Setup(x => x.Restaurants).Returns(mockRestaurantSet.Object);
    }
}