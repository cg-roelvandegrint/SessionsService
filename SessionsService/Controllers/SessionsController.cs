using Microsoft.AspNetCore.Mvc;

namespace SessionsService.Controllers;

[ApiController]
[Route("[controller]")]
public class SessionsController : ControllerBase
{
    private readonly ILogger<SessionsController> _logger;

    public SessionsController(ILogger<SessionsController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public IEnumerable<Session> Get()
    {
        _logger.LogInformation("Sessions endpoint hit");

        return new Session[] {
            new("Awesome Blazor", "John Galloway", "30 mins"),
            new("C# 10", "Mads", "45 mins"),
            new("Real-world minimal API's", "Shawn Wildermuth", "30 mins")
        };
    }
}
