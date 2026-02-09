import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_user_model.freezed.dart';
part 'message_user_model.g.dart';

@freezed
abstract class MessageUserModel with _$MessageUserModel {
  factory MessageUserModel({
    @JsonKey(fromJson: _ciFromJson) String? ci,
    String? nombreCompleto,
    int? msPersonaId,
    int? funcionarioId,
    int? institucionId,
    int? oficinaId,
  }) = _MessageUserModel;

  factory MessageUserModel.fromJson(Map<String, dynamic> json) =>
      _$MessageUserModelFromJson(json);
}

/// Conversor para manejar ci como int o String del JSON
String? _ciFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is int) return value.toString();
  return null;
}
