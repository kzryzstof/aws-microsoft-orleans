using System.Net;
using System.Net.Mime;
using Asp.Versioning;
using CommunityToolkit.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace DriftingBytesLabs.AwsOrleans.Host.Api.v1;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/forecast")]
[Produces(MediaTypeNames.Application.Json)]
public sealed class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries =
    [
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    ];
    
    private readonly ILogger<WeatherForecastController> _logger;

    public WeatherForecastController
    (
        ILogger<WeatherForecastController> logger
    )
    {
        Guard.IsNotNull(logger);

        _logger = logger;
    }

    [ProducesResponseType(typeof(List<WeatherForecast>), StatusCodes.Status200OK)]
    [HttpGet]
    public IActionResult GetAsync
    (
        CancellationToken cancellationToken
    )
    {
        //using Activity? activity = ServiceActivitySources.Api.StartActivity();
        
        try
        {
            _logger.LogWarning("--> RECEIVED REQUEST!!");
            
            var forecast = Enumerable
                .Range(1, 5)
                .Select
                (
                    index => new WeatherForecast
                    (
                        DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                        Random.Shared.Next(-20, 55),
                        Summaries[Random.Shared.Next(Summaries.Length)]
                    )
                )
                .ToArray();
            
            return Ok(forecast);
        }
        catch
        {
            return StatusCode((int)HttpStatusCode.InternalServerError);
        }
    }
}