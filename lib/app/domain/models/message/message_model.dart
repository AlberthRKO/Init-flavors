import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message/message_destino/message_destino_model.dart';
import 'package:gw_sms/app/domain/models/message/message_origen/message_origen_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  factory MessageModel({
    @JsonKey(name: '_id') String? id,
    MessageOrigenModel? origen,
    MessageDestinoModel? destino,
    String? estado,
    String? createdAt,
    String? updatedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
