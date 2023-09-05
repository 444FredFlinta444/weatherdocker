# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY *.csproj ./
RUN dotnet restore

# Copy the application code into the container
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image as the base image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Set the working directory
WORKDIR /app

# Copy the built application from the build image
COPY --from=build /app/out ./

# Expose the port your application listens on
EXPOSE 80

# Start your application when the container starts
ENTRYPOINT ["dotnet", "dotnetDocker.dll"]
