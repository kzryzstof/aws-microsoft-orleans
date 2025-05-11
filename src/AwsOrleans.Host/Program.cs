using DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Injection;
using DriftingBytesLabs.AwsOrleans.Host.Api.v1;
using Scalar.AspNetCore;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

//  --------------------------------------------------------------------------------------------------------------------
//  Injects our services
//  --------------------------------------------------------------------------------------------------------------------
builder.Services
    .AddDirectoryServices()
    ;

//  --------------------------------------------------------------------------------------------------------------------
//  Sets up Open API.
//  --------------------------------------------------------------------------------------------------------------------
builder.Services
    .AddEndpointsApiExplorer()
    .AddOpenApi();

WebApplication app = builder.Build();

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.MapOpenApi();
    app.MapScalarApiReference();
//}

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
    {
        var forecast = Enumerable
            .Range(1, 5)
            .Select
            (
                index => new WeatherForecast
                (
                    DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                    Random.Shared.Next(-20, 55),
                    summaries[Random.Shared.Next(summaries.Length)]
                )
            )
            .ToArray();
        return forecast;
    })
    .WithName("GetWeatherForecast");

app.Run();