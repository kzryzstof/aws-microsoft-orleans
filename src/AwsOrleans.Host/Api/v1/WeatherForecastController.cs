using System.Net;
using System.Net.Mime;
using Asp.Versioning;
using CommunityToolkit.Diagnostics;
using DriftingBytesLabs.AwsOrleans.Abstractions.Entities;
using DriftingBytesLabs.AwsOrleans.Abstractions.Services;
using Microsoft.AspNetCore.Mvc;

namespace DriftingBytesLabs.AwsOrleans.Host.Api.v1;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/forecast")]
[Produces(MediaTypeNames.Application.Json)]
public sealed class WeatherForecastController : ControllerBase
{
    private readonly ILogger<WeatherForecastController> _logger;
    private readonly IDirectoryService _directoryService;

    public WeatherForecastController
    (
        ILogger<WeatherForecastController> logger,
        IDirectoryService directoryService
    )
    {
        Guard.IsNotNull(logger);
        Guard.IsNotNull(directoryService);

        _logger = logger;
        _directoryService = directoryService;
    }

    [ProducesResponseType(typeof(List<WeatherForecast>), StatusCodes.Status200OK)]
    [HttpGet]
    public async Task<IActionResult> GetAsync
    (
        [FromQuery(Name = "postalCode")]
        string postalCode,
        CancellationToken cancellationToken
    )
    {
        //using Activity? activity = ServiceActivitySources.Api.StartActivity();
        
        try
        {
            _logger.LogWarning("--> RECEIVED REQUEST!!");
            
            var forecast = await _directoryService.GetAsync
            (
                postalCode
            );
            
            return Ok(forecast);
        }
        catch
        {
            return StatusCode((int)HttpStatusCode.InternalServerError);
        }
    }
}