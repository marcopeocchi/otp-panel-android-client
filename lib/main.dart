import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:sms_listener/pages/home.dart';
import 'package:sms_listener/repository/config_repository.dart';
import 'package:sms_listener/state/config_store.dart';

const androidConfig = FlutterBackgroundAndroidConfig(
  notificationTitle: "Fantasie Impromptu",
  notificationText: "Running background SMS listener",
  notificationImportance: AndroidNotificationImportance.Default,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await telephony.requestPhoneAndSmsPermissions;
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
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Provider(
        create: ((context) => ConfigStore(ConfigRepository())),
        child: const Home(),
      ),
    );
  }
}
