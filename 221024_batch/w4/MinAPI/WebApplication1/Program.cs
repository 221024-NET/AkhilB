
using Microsoft.Extensions.Logging.Configuration;
using Microsoft.Extensions.Primitives;
using MinAPI.Data;

var builder = WebApplication.CreateBuilder(args);
var configuration = new ConfigurationBuilder()
    .AddEnvironmentVariables()
    .AddCommandLine(args)
    .AddJsonFile("appsettings.json")
    .AddUserSecrets<Program>(true)
    .Build();


// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


//string connvalue = builder.Configuration.GetValue<string>("ConnectionString:SqlServerDB");
//builder.Configuration.SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("Secrets.json").AddUserSecrets<Program>(true);
//string connvalue = File.ReadAllText("connection.txt");

var connvalue = builder.Configuration.GetValue<string>("ConnectionStrings:SqlServerConx");
builder.Services.AddTransient<SqlRepo>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateTime.Now.AddDays(index),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast");

app.MapGet("/hello", () => "Hello World!");

app.MapGet("/persons", (SqlRepo repo) =>
    repo.getAllPersons(connvalue));

app.MapGet("/console", () => Console.WriteLine("Option 1\nOption 2\n Option 3"));

app.Run();

internal record WeatherForecast(DateTime Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}