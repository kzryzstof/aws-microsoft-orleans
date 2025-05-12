using DriftingBytesLabs.AwsOrleans.Abstractions.Entities;

namespace DriftingBytesLabs.AwsOrleans.Directory.Persistence.v1;

internal interface IWeatherForecastController : IGrainWithStringKey
{
    Task<WeatherForecast[]> GetAsync();
}