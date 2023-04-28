FROM ethereum/client-go:alltools-latest

# Install required packages
RUN apk add --no-cache curl jq

# ADD . /debug
# Set the working directory
# WORKDIR /debug

# Copy the password file
COPY root-password.txt /debug/root-password.txt

# Copy the startup script
COPY start.sh /debug/start.sh

# Set the proper permissions for the script
RUN chmod -R 777 /debug

# Set the proper permissions for the script
# RUN chmod +x /tmp/start.sh

# Create a user with a known UID/GID within range 10000-20000.
# This is required by Choreo to run the container as a non-root user.
RUN adduser \
    --disabled-password \
    --gecos "" \
    --uid 10014 \
    "choreo"

RUN chown -R choreo:choreo /debug

# Use the above created unprivileged user
USER 10014

# Expose the required ports
EXPOSE 30301 30310 30311 8040 8041 8551 8552

# Set the entry point to the startup script
ENTRYPOINT ["/bin/sh", "/debug/start.sh"]
