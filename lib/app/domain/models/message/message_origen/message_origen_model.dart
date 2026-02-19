import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message/message_origen/message_usuario/message_usuario_model.dart';

part 'message_origen_model.freezed.dart';
part 'message_origen_model.g.dart';

@freezed
abstract class MessageOrigenModel with _$MessageOrigenModel {
  factory MessageOrigenModel({
    String? aplicacion,
    String? modulo,
    String? numero,
    MessageUsuarioModel? usuario,
  }) = _MessageOrigenModel;

  factory MessageOrigenModel.fromJson(Map<String, dynamic> json) =>
      _$MessageOrigenModelFromJson(json);
}
