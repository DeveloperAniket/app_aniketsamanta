 
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app
    
# Copy csproj and restore as distinct layers
COPY ./nagp-devops-us/*.csproj ./
RUN dotnet restore
    
# Copy everything else and build
COPY ./nagp-devops-us ./
RUN dotnet publish -c Release -o out
    
# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "nagp-devops-us.dll"]