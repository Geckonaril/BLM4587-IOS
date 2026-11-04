
using Microsoft.EntityFrameworkCore;
using Takvim.Api.Data;

var builder = WebApplication.CreateBuilder(args);

// Controller desteği
builder.Services.AddControllers();

// OpenAPI desteği
builder.Services.AddOpenApi();

// PostgreSQL bağlantısı
var connectionString =
    builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException(
        "DefaultConnection yapılandırılmamış.");

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(connectionString));

var app = builder.Build();

// Geliştirme ortamında OpenAPI
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.MapControllers();

app.Run();
