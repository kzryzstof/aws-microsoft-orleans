namespace DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Configurations;

internal sealed class OrleansConfiguration
{
    public string ClusterId { get; init; } = string.Empty;
    
    public string ServiceId { get; init; } = string.Empty;
    
    public string ClusterStorageAccountConnectionString { get; init; } = string.Empty;
}