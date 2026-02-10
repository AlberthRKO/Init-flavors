import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message/message_user/message_user_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  factory MessageModel({
    String? messageId,
    String? chatId,
    String? message,
    String? app,
    MessageUserModel? user,
    String? phone,
    String? mode,
    int? messageType,
    int? status, // 0 = Pendiente, 1 = Enviado, 2 = Fallido
    String? createdAt,
    String? updatedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
