namespace JwtAuthDemo.Services
{
    public interface ICacheService
    {
        T? GetOrSet<T>(string key, Func<T> getData, TimeSpan expire);
    }
}