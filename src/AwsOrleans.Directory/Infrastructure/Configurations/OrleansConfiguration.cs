namespace DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Configurations;

internal sealed class OrleansConfiguration
{
    public string ClusterId { get; init; } = string.Empty;
    
    public string ServiceId { get; init; } = string.Empty;
    
    public string ClusteringTableName { get; init; } = string.Empty;

    public string DataGrainTableName { get; init; } = string.Empty;

    public string Region { get; init; } = string.Empty;
}