FROM ubuntu

RUN apt-get update -y

RUN apt-get install -y python2.7 libpython2.7 libpython2.7-dev golang \
          build-essential gcc g++ gcc-multilib g++-multilib ant \
          ant-optional make time libboost-all-dev libgmp10 libgmp-dev \
          zlib1g zlib1g-dev libssl-dev openjdk-8-jdk git

RUN mkdir /zkp
COPY . /zkp

WORKDIR /zkp/thirdparty
RUN /zkp/thirdparty/install_pepper_deps.sh

WORKDIR /zkp/pepper
CMD ["/zkp/pepper/setup.sh", "proof_of_balance"]
