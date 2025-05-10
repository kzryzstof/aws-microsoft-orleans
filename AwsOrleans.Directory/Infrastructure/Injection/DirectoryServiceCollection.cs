using DriftingBytesLabs.AwsOrleans.Abstractions.Services;
using DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Configurations;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Orleans.Configuration;

namespace DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Injection;

public static class DirectoryServiceCollection
{
    public static IHostBuilder UseDirectoryServices
    (
        this IHostBuilder hostBuilder
    )
    {
        hostBuilder.UseOrleans((hostBuilderContext, siloBuilder) =>
        {
            var orleansConfiguration = new OrleansConfiguration();
            hostBuilderContext.Configuration.Bind(nameof(OrleansConfiguration), orleansConfiguration);
            
            ConfigureCluster(siloBuilder, orleansConfiguration);
            
            ConfigureClustering(siloBuilder, orleansConfiguration);

            ConfigureEndpoint(siloBuilder);

            ConfigureGrainStorage(hostBuilderContext, siloBuilder, orleansConfiguration);
        });
        
        return hostBuilder;
    }

    public static IServiceCollection AddDirectoryServices
    (
        this IServiceCollection serviceCollection
    )
    {
        //  Inject public services.
        serviceCollection.AddSingleton<IDirectoryService, DirectoryService>();
        
        //  Inject internal services.
        serviceCollection.AddSingleton(TimeProvider.System);
        
        return serviceCollection;
    }

    private static void ConfigureCluster
    (
        ISiloBuilder siloBuilder,
        OrleansConfiguration orleansConfiguration
    )
    {
        siloBuilder.Configure<ClusterOptions>(options =>
        {
            options.ClusterId = orleansConfiguration.ClusterId;
            options.ServiceId = orleansConfiguration.ServiceId;
        });
    }

    private static void ConfigureClustering
    (
        ISiloBuilder siloBuilder,
        OrleansConfiguration orleansConfiguration
    )
    {
        if (RunsLocally)
        {
            siloBuilder.UseLocalhostClustering();
        }
        else
        {
            // siloBuilder.UseAzureStorageClustering(options =>
            // {
            //     options.TableServiceClient = new TableServiceClient
            //     (
            //         orleansConfiguration.ClusterStorageAccountConnectionString
            //     );
            // });
        }
    }
    
    private static void ConfigureEndpoint
    (
        ISiloBuilder siloBuilder
    )
    {
        if (RunsLocally)
            return;
        
        siloBuilder.ConfigureEndpoints(11111, 30000);
    }
    
    private static void ConfigureGrainStorage
    (
        HostBuilderContext hostBuilderContext,
        ISiloBuilder siloBuilder,
        OrleansConfiguration orleansConfiguration
    )
    {
        // siloBuilder.AddAzureTableGrainStorage
        // (
        //     "devices",
        //     options =>
        //     {
        //         options.DeleteStateOnClear = true;
        //         
        //         options.TableServiceClient = new TableServiceClient
        //         (
        //             orleansConfiguration.UsersStorageAccountConnectionString
        //         );
        //     }
        // );
    }

    private static bool RunsLocally
    {
        get
        {
#if DEBUG
            return true;
#endif

#pragma warning disable CS0162 // Unreachable code detected
            return false;
#pragma warning restore CS0162 // Unreachable code detected
        }
    }
}