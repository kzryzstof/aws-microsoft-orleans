using CommunityToolkit.Diagnostics;
using DriftingBytesLabs.AwsOrleans.Abstractions.Entities;
using DriftingBytesLabs.AwsOrleans.Abstractions.Services;
using DriftingBytesLabs.AwsOrleans.Directory.Persistence.v1;

namespace DriftingBytesLabs.AwsOrleans.Directory;

internal sealed class DirectoryService : IDirectoryService
{
    private readonly IClusterClient _clusterClient;
    
    public DirectoryService
    (
        IClusterClient clusterClient
    )
    {
        Guard.IsNotNull(clusterClient);
        
        _clusterClient = clusterClient;
    }
    
    public async Task<WeatherForecast[]> GetAsync
    (
        string postalCode
    )
    {
       return await _clusterClient
            .GetGrain<IWeatherForecastController>(postalCode.ToLowerInvariant())
            .GetAsync();    
    }
}