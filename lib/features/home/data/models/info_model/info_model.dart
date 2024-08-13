import 'data.dart';

class InfoModel {
  Data? data;
  String? message;

  InfoModel({this.data, this.message});

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
      };
}
