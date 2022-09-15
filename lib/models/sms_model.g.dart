// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SMSModel _$SMSModelFromJson(Map<String, dynamic> json) => SMSModel(
      message: json['message'] as String,
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$SMSModelToJson(SMSModel instance) => <String, dynamic>{
      'message': instance.message,
      'sender': instance.sender,
      'recipient': instance.recipient,
    };
