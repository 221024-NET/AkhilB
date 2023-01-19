using RST.API.Controllers;

namespace RST.Test;

public class RestaurantControllerTest : IClassFixture<RstFixture>
{
    private readonly RstFixture _fixture;

    public RestaurantControllerTest(RstFixture fixture){
        this._fixture = fixture;
    }

    [Fact]
    public async void GetReturnsList(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);

        // * ACT
        var result = await controller.Get();

        // * ASSERT
        Assert.IsType<List<Restaurant>>(result.Value);
    }

    [Fact]
    public async void GetIdReturnsNotFound(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        int id = 0;

        // * ACT
        var result = await controller.Get(id);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.NotFoundResult>(result.Result);
    }

    [Fact]
    public async void GetIdReturnsRestaurant(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        int id = 1;

        // * ACT
        var result = await controller.Get(id);

        // * ASSERT
        Assert.IsType<Restaurant>(result.Value);
    }

    [Fact]
    public async void PostReturnsBadRequest(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        var tmpR = new Restaurant{rName="Name", grade = 'F'};

        // * ACT
        var result = await controller.Post(tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.BadRequestObjectResult>(result.Result);
    }

    [Fact]
    public async void PostReturnsCreated(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        var tmpR = new Restaurant {rName="Name", rAddress="Address", rCity="City", rState="State", grade='D'};

        // * ACT
        var result = await controller.Post(tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.CreatedAtActionResult>(result.Result);
    }

    [Fact]
    public async void PutReturnsBadRequest(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        int id = 0;
        var tmpR = new Restaurant{restID=1, rName="NewName"};

        // * ACT
        var result = await controller.Put(id, tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.BadRequestObjectResult>(result);
    }

    [Fact]
    public async void PutReturnsNotFound(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        int rid=0;
        var tmpR = new Restaurant{restID=rid, rName="Name"};

        // * ACT
        var result = await controller.Put(rid, tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.NotFoundObjectResult>(result);
    }

    [Fact]
    public async void PutReturnsNoContent(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        int rid=1;
        var tmpR = this._fixture.Context.Restaurants.ToList<Restaurant>().First();
        tmpR.rName = "NewName";

        // * ACT
        var result = await controller.Put(rid, tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.NoContentResult>(result);
    }

    [Fact]
    public async void DeleteReturnsNotFound(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        var tmpR = new Restaurant{restID = 0};

        // * ACT
        var result = await controller.Delete(tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.NotFoundObjectResult>(result);
    }

    [Fact]
    public async void DeleteReturnsNoContent(){
        // * ARRANGE
        var controller = new RestaurantController(this._fixture.Context);
        var tmpR = this._fixture.Context.Restaurants.ToList<Restaurant>().First();

        // * ACT
        var result = await controller.Delete(tmpR);

        // * ASSERT
        Assert.IsType<Microsoft.AspNetCore.Mvc.NoContentResult>(result);
    }
}