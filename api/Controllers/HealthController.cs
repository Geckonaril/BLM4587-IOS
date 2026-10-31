
using Microsoft.AspNetCore.Mvc;

namespace Takvim.Api.Controllers;

[ApiController]
[Route("api/health")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Get()
    {
        return Ok(new
        {
            status = "ok",
            application = "Takvim API",
            message = "API çalışıyor"
        });
    }
}
