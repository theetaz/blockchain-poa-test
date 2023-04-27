FROM ethereum/client-go:alltools-latest

# Install required packages
RUN apk add --no-cache curl jq

# Set the working directory
WORKDIR /tmp

# Copy the password file
COPY root-password.txt /tmp/root-password.txt

# Copy the startup script
COPY start.sh /tmp/start.sh

# Set the proper permissions for the script
RUN chmod +x /tmp/start.sh

# Create a user with a known UID/GID within range 10000-20000.
# This is required by Choreo to run the container as a non-root user.
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid 10014 \
    "choreo"

# Use the above created unprivileged user
USER 10014

# Expose the required ports
EXPOSE 30301 30310 30311 8040 8041 8551 8552

# Set the entry point to the startup script
ENTRYPOINT ["/bin/sh", "/tmp/start.sh"]
