using Asp.Versioning;

namespace DriftingBytesLabs.AwsOrleans.Host.Infrastructure.OpenApi;

internal static class WebApplicationBuilderExtension
{
    public static void ConfigureOpenApi
    (
        this WebApplicationBuilder builder
    )
    {
        builder
            .Services
            .AddEndpointsApiExplorer()
            .AddApiVersioning
            (
                options =>
                {
                    options.AssumeDefaultVersionWhenUnspecified = true;
                    options.ReportApiVersions = true;
                    options.DefaultApiVersion = new ApiVersion(1, 0);
        
                    options.ApiVersionReader = new UrlSegmentApiVersionReader();
                }
            )
            .AddApiExplorer
            (
                apiExplorerOptions =>
                {
                    apiExplorerOptions.GroupNameFormat = "'v'VVV";
                    apiExplorerOptions.SubstituteApiVersionInUrl = true;
                }
            );
        
        builder
            .Services
            .AddOpenApi("v1");
    }
}