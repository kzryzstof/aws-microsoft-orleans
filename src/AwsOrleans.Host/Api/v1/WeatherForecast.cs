using System.Text.Json.Serialization;

namespace DriftingBytesLabs.AwsOrleans.Host.Api.v1;

public readonly record struct WeatherForecast
(
    DateOnly Date,
    int TemperatureC,
    string Summary = ""
)
{
    [JsonIgnore]
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}