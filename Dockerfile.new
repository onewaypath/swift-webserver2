# Use an appropriate base image that supports Swift and provides the necessary dependencies
FROM swift:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Vapor project files into the container
COPY . .

# Build your Vapor project inside the container
RUN swift build

# Expose the necessary ports
EXPOSE 8080

# Set the entry point command to run your Vapor executable
CMD ["./.build/debug/Run"]
