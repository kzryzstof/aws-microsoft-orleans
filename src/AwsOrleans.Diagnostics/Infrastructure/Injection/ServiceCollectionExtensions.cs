using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using OpenTelemetry;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;

namespace AwsOrleans.Diagnostics.Infrastructure.Injection;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddDiagnosticsServices
    (
        this IServiceCollection services,
        IConfiguration configuration
    )
    {
        //  Configures OTel.
        services
            .AddOpenTelemetry()
            .ConfigureResource
            (
                (resourceBuilder) => resourceBuilder
                    .AddContainerDetector()
                    .AddEnvironmentVariableDetector()
                    .AddTelemetrySdk()
                    .AddService("Connect Manager", serviceInstanceId: Environment.MachineName)
                    .AddAttributes(new Dictionary<string, object> { { "podname", Environment.MachineName } })
            )
            .WithMetrics
            (
                metricsBuilder =>
                {
                    metricsBuilder.AddAWSInstrumentation();
                    metricsBuilder.AddAspNetCoreInstrumentation();
                    metricsBuilder.AddRuntimeInstrumentation();
                    metricsBuilder.AddHttpClientInstrumentation();
                    
                    //  Injects the service's custom metrics.
                }
            )
            .WithTracing
            (
                tracingBuilder =>
                {
                    //  Injects the service's custom tracing.
                    tracingBuilder.AddSource
                    (
                        "DriftingBytesLabsDemoTape.*"
                    );
                    
                    tracingBuilder.AddAspNetCoreInstrumentation
                    (
                        builder => { builder.RecordException = true; }
                    );
                    
                    tracingBuilder.AddHttpClientInstrumentation
                    (
                        builder => { builder.RecordException = true; }
                    );

                    /*
                    tracingBuilder.SetSampler
                    (
                        new ParentBasedSampler
                        (
                            new TraceIdRatioBasedSampler(0.05)
                        )
                    );
                    */
                }
            )
            // .UseAzureMonitor
            // (
            //     options =>
            //     {
            //         options.ConnectionString = configuration.GetValue<string>("APPLICATIONINSIGHTS_CONNECTION_STRING");
            //         //options.SamplingRatio = 0.05f;
            //     }
            // )
#if DEBUG
            .UseOtlpExporter()
#endif
            ;
        
        services.AddLogging
        (
            builder =>
            {
                builder.AddOpenTelemetry
                (
                    options =>
                    {
                        options.SetResourceBuilder
                        (
                            ResourceBuilder
                                .CreateDefault()
                                //.AddContainerDetector()
                                .AddEnvironmentVariableDetector()
                                .AddTelemetrySdk()
                                .AddService("Orleans", serviceInstanceId: Environment.MachineName)
                                .AddAttributes
                                (
                                    new Dictionary<string, object>
                                    {
                                        { "podname", Environment.MachineName }
                                    }
                                )
                        );

                        options.IncludeFormattedMessage = true;
                        options.IncludeScopes = true;
                        options.ParseStateValues = true;
                    }
                );
            }
        );

        return services;
    }
}