using System.Text.Json.Serialization;
using JetBrains.Annotations;

namespace DriftingBytesLabs.AwsOrleans.Directory.Persistence.v1;

[UsedImplicitly]
internal sealed class WeatherForecastState
{
    [JsonPropertyName("callsCount")]
    public int CallsCount { get; set; }
}