#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SessionsService/SessionsService.csproj", "SessionsService/"]
RUN dotnet restore "SessionsService/SessionsService.csproj"
COPY . .
WORKDIR "/src/SessionsService"
RUN dotnet build "SessionsService.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SessionsService.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SessionsService.dll"]