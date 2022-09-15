import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sms_listener/models/sms_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://10.0.0.9:3000/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/range/{range}')
  Future<List<SMSModel>> getMessageRange(@Path('range') int range);

  @POST('/publish')
  Future<SMSModel> publishMessage(@Body() SMSModel sms);
}
