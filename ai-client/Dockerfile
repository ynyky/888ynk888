FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user first
RUN useradd -m -u 10001 claude

USER claude
WORKDIR /home/claude

# Ensure local bin is on PATH
ENV PATH="/home/claude/.local/bin:${PATH}"

# Download and install as the claude user
RUN curl -fsSL -o /tmp/claude-install.sh https://claude.ai/install.sh \
    && chmod 700 /tmp/claude-install.sh \
    && bash /tmp/claude-install.sh \
    && rm -f /tmp/claude-install.sh

CMD ["claude"]
