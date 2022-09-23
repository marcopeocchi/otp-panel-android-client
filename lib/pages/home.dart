import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_listener/models/config_model.dart';
import 'package:sms_listener/services/sms_service.dart';
import 'package:sms_listener/state/config_store.dart';
import 'package:telephony/telephony.dart';

final telephony = Telephony.instance;

//TODO: needs a rework
backgroundMessageHandler(SmsMessage message) async {
  final prefs = await SharedPreferences.getInstance();
  SMSService().url = prefs.getString('api_url_plain') ?? '';
  SMSService().publishMessage(message);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ConfigStore _store;
  late List<ReactionDisposer> _disposers;

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ConfigStore>(context);
    _store.getConfig();

    _disposers = [
      reaction(
        (_) => _store.config,
        (ConfigModel cfg) {
          _controller.text = _store.config.url;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'API address is ${cfg.url}\nA restart might be necessary!',
              ),
            ),
          );
        },
      ),
      reaction(
        (_) => _store.config,
        (ConfigModel cfg) {
          telephony.listenIncomingSms(
            onNewMessage: (SmsMessage message) {
              SMSService().url = cfg.url;
              SMSService().publishMessage(message);
            },
            onBackgroundMessage: backgroundMessageHandler,
          );
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMS Listener')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Observer(
              builder: ((context) {
                return TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Set API address [http://<youraddress>]',
                  ),
                );
              }),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _store.setConfig(_controller.text);
                }
              },
              child: const Text('Change address'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposers.map((disposer) => disposer());
    _controller.dispose();
    super.dispose();
  }
}
