using Microsoft.Extensions.Caching.Memory;

namespace JwtAuthDemo.Services
{
    public class CacheService : ICacheService
    {
        private readonly IMemoryCache _cache;
        public CacheService(IMemoryCache cache)
        {
            _cache = cache;
        }

        public T? GetOrSet<T>(string key, Func<T> getData, TimeSpan expire)
        {
            if (!_cache.TryGetValue(key, out T? value))
            {
                value = getData();
                _cache.Set(key, value, expire);
            }
            return value;
        }
    }
}