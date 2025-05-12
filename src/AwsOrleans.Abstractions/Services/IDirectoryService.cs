using DriftingBytesLabs.AwsOrleans.Abstractions.Entities;

namespace DriftingBytesLabs.AwsOrleans.Abstractions.Services;

public interface IDirectoryService
{
    Task<WeatherForecast[]> GetAsync
    (
        string postalCode
    );
}