import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:sms_listener/data/rest_client.dart';
import 'package:sms_listener/models/sms_model.dart';
import 'package:telephony/telephony.dart';

final telephony = Telephony.instance;
const androidConfig = FlutterBackgroundAndroidConfig(
  notificationTitle: "Mephisto Waltz",
  notificationText: "Running background SMS listener",
  notificationImportance: AndroidNotificationImportance.Default,
);

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
  await FlutterBackground.initialize(androidConfig: androidConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    enableBackgroundExec();
  }

  Future<bool> enableBackgroundExec() async {
    return await FlutterBackground.enableBackgroundExecution();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Listener',
      theme: ThemeData(
        brightness: Brightness.dark,
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
