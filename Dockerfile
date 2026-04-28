FROM python:3.9-slim

# Set working directory
WORKDIR /app/backend

# Install system dependencies (cached layer)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (enables caching)
COPY requirements.txt .

# Install Python dependencies (CACHE ENABLED)
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Run application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
