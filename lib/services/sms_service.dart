import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:sms_listener/data/rest_client.dart';
import 'package:sms_listener/models/sms_model.dart';
import 'package:telephony/telephony.dart';

class SMSService {
  static final SMSService _instance = SMSService._private();

  SMSService._private();

  factory SMSService() {
    return _instance;
  }

  String _url = "";

  set url(String url) => _url = url;

  void publishMessage(SmsMessage message) {
    final RestClient client = RestClient(
      Dio()
        ..interceptors.addAll(
          [DioLoggingInterceptor(level: Level.body)],
        )
        ..options.baseUrl = _url,
    );
    client.publishMessage(SMSModel(
      message: message.body ?? '',
      sender: message.address ?? '',
      recipient: 'Me',
    ));
  }
}
