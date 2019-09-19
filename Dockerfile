FROM python:3.7-alpine3.10

# Create user and workdir
RUN addgroup app && \
  adduser -D -G app app && \
  mkdir -p /app && \
  chown -R app /app

# Install system packages
RUN apk add --no-cache bash

# Install pip dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Switch to application context
WORKDIR /app
USER app

# Copy source code
COPY api /app/api

# Run application
CMD python -m api
