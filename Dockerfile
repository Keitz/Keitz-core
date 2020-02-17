From mcr.microsoft.com/dotnet/core/runtime-deps:3.0
WORKDIR /home
ARG TOKEN=
ARG REPO=

ADD run_runner.sh .

RUN apt-get update \
    && apt-get install curl vim sudo git -y \
    && curl -O -L https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-x64-2.164.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.164.0.tar.gz \
    && chmod 777 ./config.sh \
    && chmod 777 ./run_runner.sh
   
RUN useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo \
    && sudo usermod -G sudo admin \
    && echo "admin ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-for-password \
    && chown admin:admin /home

USER admin


   
ENTRYPOINT ["./run_runner.sh"]