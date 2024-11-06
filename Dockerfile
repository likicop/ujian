# Menggunakan image dasar Ubuntu 22.04
FROM ubuntu:22.04

# Menetapkan variabel lingkungan
ENV RUNNER_VERSION=2.301.0
ENV RUNNER_USER=runner
ENV RUNNER_HOME=/home/$RUNNER_USER
ENV RUNNER_WORKDIR=$RUNNER_HOME/actions-runner

# Install dependensi
RUN apt-get update && \
    apt-get install -y curl git libicu-dev && \
    apt-get clean

# Buat user untuk runner
RUN useradd -m $RUNNER_USER

# Pindah ke direktori user
WORKDIR $RUNNER_WORKDIR

# Unduh dan ekstrak GitHub Actions runner
RUN curl -o actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz && \
    tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz && \
    rm actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

# Set permissions
RUN chown -R $RUNNER_USER:$RUNNER_USER $RUNNER_HOME

# Pindah ke user runner
USER $RUNNER_USER

# Menentukan perintah untuk menjalankan container
ENTRYPOINT ["./config.sh"]
