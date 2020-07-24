FROM debian:buster

RUN apt-get update

RUN apt-get install -y wget gpg apt-transport-https unzip

RUN wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget https://packages.microsoft.com/config/debian/9/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update && apt-get install -y dotnet-sdk-2.1
RUN wget https://github.com/Azure-Samples/azure-iot-samples-csharp/archive/master.zip
RUN unzip master.zip
RUN dotnet build azure-iot-samples-csharp-master/iot-hub/Quickstarts/device-streams-proxy/device/
RUN dotnet build azure-iot-samples-csharp-master/iot-hub/Quickstarts/device-streams-proxy/service/

ADD start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
