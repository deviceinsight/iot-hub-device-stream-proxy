#!/bin/bash

function help {
    echo "Usage:"
    echo "  service CONNECTION_STRING DEVICE_ID PORT: As a service, create a device stream to device DEVICE_ID. Open up local port PORT and proxy incoming connections"
    echo "  device CONNECTION_STRING HOST PORT: As a device, proxy connections to HOST on port PORT"
}

MODE=$1

if [ "$#" -ne 4 ]; then
    help
    exit 1
fi

if [ "$MODE" = "--help" ]
then
    help
    exit 0
elif [ "$MODE" = "device" ]
then
    CONNECTION_STRING=$2
    HOST=$3
    PORT=$4
    echo "Device mode: Proxying to $HOST:$PORT"
    dotnet run --project /azure-iot-samples-csharp-master/iot-hub/Quickstarts/device-streams-proxy/device/ "$CONNECTION_STRING" $HOST $PORT
elif [ "$MODE" = "service" ]
then
    CONNECTION_STRING=$2
    DEVICE_ID=$3
    PORT=$4
    echo "Service mode: Connecting to device $DEVICE_ID and listing for connections on port $PORT"
    dotnet run --project /azure-iot-samples-csharp-master/iot-hub/Quickstarts/device-streams-proxy/service/ "$CONNECTION_STRING" $DEVICE_ID $PORT
else
    echo "First parameter must be 'device' or 'service'"
    exit 1
fi
