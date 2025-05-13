using System.Text.Json.Serialization;

namespace DriftingBytesLabs.AwsOrleans.Abstractions.Entities;

[GenerateSerializer]
public readonly record struct WeatherForecast
(
    [property: Id(0)]
    [property: JsonPropertyName("machineName")]
    string MachineName,
    [property: Id(1)]
    [property: JsonPropertyName("date")]
    DateOnly Date,
    [property: Id(2)]
    [property: JsonPropertyName("temperatureCelsius")]
    int TemperatureC,
    [property: Id(3)]
    [property: JsonPropertyName("summary")]
    string Summary,
    [property: Id(4)]
    [property: JsonPropertyName("callCount")]
    int Count
)
{
    [JsonIgnore]
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}