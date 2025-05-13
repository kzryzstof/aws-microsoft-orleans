using CommunityToolkit.Diagnostics;
using DriftingBytesLabs.AwsOrleans.Abstractions.Entities;

namespace DriftingBytesLabs.AwsOrleans.Directory.Persistence.v1;

internal sealed class WeatherForecastGrain : Grain, IWeatherForecastController
{
    private static readonly string[] Summaries =
    [
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    ];

    private readonly IPersistentState<WeatherForecastState> _state;
    
    public WeatherForecastGrain
    (
        [PersistentState("weather_forecast", Wellknown.DataStorageName)]
        IPersistentState<WeatherForecastState> state
    )
    {
        Guard.IsNotNull(state);
        
        _state = state;
    }

    public override Task OnActivateAsync(CancellationToken cancellationToken)
    {
        return base.OnActivateAsync(cancellationToken);
    }

    public async Task<WeatherForecast[]> GetAsync()
    {
        _state.State.CallsCount++;
        
        await _state.WriteStateAsync();
        
        return Enumerable
                .Range(1, 5)
                .Select
                (
                    index => new WeatherForecast
                    (
                        Environment.MachineName,
                        DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                        Random.Shared.Next(-20, 55),
                        Summaries[Random.Shared.Next(Summaries.Length)]
                    )
                )
                .ToArray();
    }
}
