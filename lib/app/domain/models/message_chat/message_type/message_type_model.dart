import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_type_model.freezed.dart';
part 'message_type_model.g.dart';

@freezed
abstract class MessageTypeModel with _$MessageTypeModel {
  factory MessageTypeModel({
    int? code,
    String? nombre,
    String? id,
    String? messageTypeId,
  }) = _MessageTypeModel;

  factory MessageTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MessageTypeModelFromJson(json);
}
