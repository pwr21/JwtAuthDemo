# ===============================
# 1️⃣ Build stage (.NET 9 SDK)
# ===============================
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src

# Copy csproj and restore
COPY *.csproj .
RUN dotnet restore

# Copy the rest of the source and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

# ===============================
# 2️⃣ Runtime stage (.NET 9 ASP.NET)
# ===============================
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app

# Copy configuration files like appsettings.json
COPY --from=build /src/appsettings*.json ./

# Copy published application
COPY --from=build /app/publish .

# Set port to expose
ENV ASPNETCORE_URLS=http://+:80

# Start the app
ENTRYPOINT ["dotnet", "JwtAuthDemo.dll"]
