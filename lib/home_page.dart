import 'package:avatar_glow/avatar_glow.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IO.Socket socket;
  double? latitude;
  double? longitude;
  String text = "";
  String _currentState = "DISCONNECTED";
  bool _isConnecting = false;
  bool _isConnected = false;
  late TextEditingController _serverUrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // initSocket();
    _serverUrl = TextEditingController();
  }

  void sendSMSMessage(recipient, content) async {
    List<String> recipients = [recipient];
    String _result = await sendSMS(
            message: content, recipients: recipients, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  Future<void> initSocket() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isConnecting = true;
        _currentState = "CONNECTING";
      });
      try {
        // Get device info
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        socket = IO.io(_serverUrl.text, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
          'auth': {'token': androidInfo.id},
          'query': {
            'device': 'android',
            'model': androidInfo.model,
            'machineId': androidInfo.id,
          }
        });

        socket.onConnectError((data) {
          disconnect();
          print(data);
        });

        socket.connect();

        socket.onConnect((data) {
          socket.emit('device-connected', {});
          setState(() {
            _isConnecting = false;
            _isConnected = true;
            _currentState = 'CONNECTED';
          });
        });

        socket.on("send-sms", (data) {
          print(data['recipient']);
          print(data['content']);
          sendSMSMessage(data['recipient'], data['content']);
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void disconnect() {
    socket.dispose();

    setState(() {
      _isConnecting = false;
      _isConnected = false;
      _currentState = 'DISCONNECTED';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ASGate',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          leading: Image.asset(
            'assets/logo.png',
            width: 35,
            height: 35,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const Background(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: Text(
                      _currentState,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    const SizedBox(height: 8),
                    Center(
                        child: Text(
                      _serverUrl.text,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: const Color.fromRGBO(37, 112, 252, 1),
                          fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: AvatarGlow(
                        glowColor: _isConnected
                            ? const Color.fromRGBO(37, 112, 252, 1)
                            : Colors.transparent,
                        endRadius: 100.0,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        animate: _isConnected || _isConnecting,
                        showTwoGlows: true,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        shape: BoxShape.circle,
                        child: Material(
                          elevation: 2,
                          shape: const CircleBorder(),
                          color: _isConnected
                              ? const Color.fromRGBO(37, 112, 252, 1)
                              : Colors.grey,
                          child: InkWell(
                            onTap: () => _isConnected
                                ? disconnect()
                                : _isConnecting
                                    ? null
                                    : initSocket(),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.power_settings_new,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _currentState,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Server URL is required';
                        }
                        return null;
                      },
                      controller: _serverUrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Server URL',
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        child: Opacity(
            opacity: .1,
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height / 1.5,
            )));
  }
}
