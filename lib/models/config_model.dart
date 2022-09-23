import 'package:json_annotation/json_annotation.dart';

part 'config_model.g.dart';

@JsonSerializable()
class ConfigModel {
  String url;

  ConfigModel({required this.url});

  factory ConfigModel.fromJSON(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);

  bool get isEmpty => this == ConfigModel.emptyConfig();
  bool get isNotEmpty => this != ConfigModel.emptyConfig();

  factory ConfigModel.emptyConfig() => ConfigModel(url: "");
}
