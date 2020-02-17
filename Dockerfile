From mcr.microsoft.com/dotnet/core/runtime-deps:3.0
WORKDIR /home
ARG TOKEN=
ARG REPO=

ADD run_runner.sh .

RUN apt-get update \
    && apt-get install curl vim sudo git docker -y \
    && curl -O -L $ curl -O -L https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.165.2.tar.gz \
    && chmod 777 ./config.sh \
    && chmod 777 ./run_runner.sh \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && sudo mv ./kubectl /usr/local/bin/kubectl



   
RUN useradd docker && echo "docker:docker" | chpasswd && adduser docker sudo \
    && sudo usermod -G sudo docker \
    && echo "docker ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-for-password \
    && chown docker:docker /home


USER docker

   
ENTRYPOINT ["./run_runner.sh"]