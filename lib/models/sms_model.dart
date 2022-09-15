import 'package:json_annotation/json_annotation.dart';

part 'sms_model.g.dart';

@JsonSerializable()
class SMSModel {
  String message;
  String sender;
  String recipient;

  SMSModel({
    required this.message,
    required this.sender,
    required this.recipient,
  });

  factory SMSModel.fromJson(Map<String, dynamic> json) =>
      _$SMSModelFromJson(json);

  Map<String, dynamic> toJson() => _$SMSModelToJson(this);
}