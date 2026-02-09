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
    @JsonKey(fromJson: _statusFromJson) String? status,
    String? createdAt,
    String? updatedAt,
    @Default(false) bool isEntregado,
    @Default(false) bool isEnviando,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

/// Conversor para manejar status como int o String del JSON
/// 0 = Pendiente, 1 = Enviado, 2 = Fallido
String? _statusFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is int) {
    switch (value) {
      case 0:
        return 'pendiente';
      case 1:
        return 'enviado';
      case 2:
        return 'fallido';
      default:
        return value.toString();
    }
  }
  return null;
}
