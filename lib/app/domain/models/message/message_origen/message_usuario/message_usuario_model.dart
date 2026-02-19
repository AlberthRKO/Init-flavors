import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_usuario_model.freezed.dart';
part 'message_usuario_model.g.dart';

@freezed
abstract class MessageUsuarioModel with _$MessageUsuarioModel {
  factory MessageUsuarioModel({
    String? ci,
    String? nombreCompleto,
  }) = _MessageUsuarioModel;

  factory MessageUsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$MessageUsuarioModelFromJson(json);
}
