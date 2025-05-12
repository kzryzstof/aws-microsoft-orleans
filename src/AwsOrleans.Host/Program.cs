using AwsOrleans.Diagnostics.Infrastructure.Injection;
using DriftingBytesLabs.AwsOrleans.Directory.Infrastructure.Injection;
using DriftingBytesLabs.AwsOrleans.Host.Infrastructure.OpenApi;
using Scalar.AspNetCore;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Host
    .UseDirectoryServices()
    ;

//  --------------------------------------------------------------------------------------------------------------------
//  Injects our services
//  --------------------------------------------------------------------------------------------------------------------
builder.Services
    .AddDiagnosticsServices(builder.Configuration)
    .AddDirectoryServices()
    ;

//  --------------------------------------------------------------------------------------------------------------------
//  Sets up Open API.
//  --------------------------------------------------------------------------------------------------------------------
builder.ConfigureOpenApi();

builder.Services
    .AddEndpointsApiExplorer()
    .AddOpenApi();

WebApplication app = builder.Build();

// Configure the HTTP request pipeline.
app.MapOpenApi();
app.MapScalarApiReference();

app.UseHttpsRedirection();

app.MapControllers();

await app.RunAsync();