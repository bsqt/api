FROM python:3.7-alpine3.10

# Create user and workdir
ARG USER=app
ARG WORKDIR=/app
RUN addgroup ${USER} && \
  adduser -D -G ${USER} ${USER} && \
  mkdir -p ${WORKDIR} && \
  chown -R ${USER} ${WORKDIR}

# Install system packages
RUN apk add --no-cache \
  bash \
  gcc \
  musl-dev \
  linux-headers \
  make

# Install pip dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Switch to application context
WORKDIR ${WORKDIR}
USER ${USER}

# Export commit info
ARG COMMIT_HASH
ARG COMMIT_MESSAGE
ENV COMMIT_HASH=${COMMIT_HASH}
ENV COMMIT_MESSAGE=${COMMIT_MESSAGE}

# Expose webserver port
EXPOSE 8000

# Copy source code
COPY api /app/api
