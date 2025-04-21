using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using JwtAuthDemo.Services;

namespace JwtAuthDemo.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CacheController : ControllerBase
    {
        private readonly ICacheService _cacheService;
        public CacheController(ICacheService cacheService)
        {
            _cacheService = cacheService;
        }

        [Authorize]
        [HttpGet("cache-demo")]
        public IActionResult GetData()
        {
            string cacheKey = "weather";
            var data = _cacheService.GetOrSet(cacheKey, () =>
            {
                return "This is cached data at " + DateTime.Now;
            }, GetExpireToMidnight());

            return Ok(data);
        }

        private TimeSpan GetExpireToMidnight()
        {
            var timeZone = TimeZoneInfo.FindSystemTimeZoneById("SE Asia Standard Time");
            var now = TimeZoneInfo.ConvertTime(DateTime.UtcNow, timeZone);
            var midnight = now.Date.AddDays(1);
            return midnight - now;
        }
    }
}