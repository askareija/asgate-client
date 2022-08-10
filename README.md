# ASGate - Client

ASGate is an application for turning your android phones into SMS gateway. This 
repository is only for client android which will be listening to API.

## How It Works

First, API server will be running for accepting REST API methods that will be used 
to interact with user. Then the client connect to the API server using WebSocket 
and listening for send-sms event from API.

## Running Application
clone this repo and asgate server repo. To run client:
```bash
flutter pub get
flutter run android
```
or download already build apk here:
