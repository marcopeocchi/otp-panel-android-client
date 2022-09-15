import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sms_listener/data/rest_client.dart';
import 'package:sms_listener/models/sms_model.dart';
import 'package:telephony/telephony.dart';

final telephony = Telephony.instance;

void publishMessage(SmsMessage message) {
  final RestClient client = RestClient(
    Dio()
      ..interceptors.addAll(
        [DioLoggingInterceptor(level: Level.body)],
      ),
  );
  client.publishMessage(SMSModel(
    message: message.body ?? '',
    sender: message.address ?? '',
    recipient: 'Me',
  ));
}

backgroundMessageHandler(SmsMessage message) async {
  publishMessage(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await telephony.requestPhoneAndSmsPermissions;
  telephony.listenIncomingSms(
    onNewMessage: (SmsMessage message) {
      publishMessage(message);
    },
    onBackgroundMessage: backgroundMessageHandler,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Listener',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('SMS Listener')),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('🪄', style: TextStyle(fontSize: 48)),
            ],
          ),
        ),
      ),
    );
  }
}
