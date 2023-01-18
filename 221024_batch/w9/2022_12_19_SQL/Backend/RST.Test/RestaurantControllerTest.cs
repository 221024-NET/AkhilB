
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

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void GetIdReturnsNotFound(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void GetIdReturnsRestaurant(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void PostReturnsCreated(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void PutReturnsBadRequest(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void PutReturnsNoContent(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void DeleteReturnsNotFound(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }

    [Fact]
    public async void DeleteReturnsNoContent(){
        // * ARRANGE

        // * ACT

        // * ASSERT
    }
}