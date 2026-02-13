# Use official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy Python file into container
COPY app.py .

# Run the program
CMD ["python", "app.py"]
