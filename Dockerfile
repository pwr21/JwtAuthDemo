# ---------- Build stage ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# ---------- Runtime stage ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app

# Copy published output
COPY --from=build /app/publish .

# Copy appsettings.json (optional if it's not published)
# COPY appsettings.json ./  <-- ปกติจะรวมอยู่ใน publish แล้ว ไม่ต้องก็ได้

# Define environment port and expose
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

# Entry point
ENTRYPOINT ["dotnet", "JwtAuthDemo.dll"]
