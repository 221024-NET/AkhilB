
using Microsoft.EntityFrameworkCore;
using RST.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var conn = builder.Configuration["ConnectionStrings:ConnX"];
builder.Services.AddDbContext<RstContext>(options => 
    options.UseSqlServer(conn));

builder.Services.AddCors(options => 
    {
        options.AddPolicy(name: "_RstAPI", policy => 
        {
            policy.WithOrigins("http://localhost:4200")
                .AllowAnyMethod()
                .AllowAnyHeader()
                .AllowCredentials();
        });
    });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("_RstAPI");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
