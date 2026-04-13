FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user first
RUN useradd -m -u 10001 claude

USER claude
WORKDIR /home/claude

# Ensure local bin is on PATH
ENV PATH="/home/claude/.local/bin:${PATH}"

# Install Claude CLI as the claude user
RUN curl -fsSL -o /tmp/claude-install.sh https://claude.ai/install.sh \
    && chmod 700 /tmp/claude-install.sh \
    && bash /tmp/claude-install.sh \
    && rm -f /tmp/claude-install.sh


# Install RTK
RUN curl -fsSL -o /tmp/rtk-install.sh https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh \
    && chmod 700 /tmp/rtk-install.sh \
    && bash /tmp/rtk-install.sh \
    && rm -f /tmp/rtk-install.sh

# Verify binaries exist (optional safety check)
RUN which claude && which rtk

# Default: run Claude through RTK
CMD ["rtk", "claude"]
