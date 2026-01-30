import 'package:freezed_annotation/freezed_annotation.dart';

part 'sender_model.freezed.dart';
part 'sender_model.g.dart';

@freezed
abstract class SenderModel with _$SenderModel {
  factory SenderModel({
    String? nombreCompleto,
    String? ci,
    int? msPersonaId,
    int? funcionarioId,
    int? departamentoId,
    int? oficinaId,
    String? oficina,
  }) = _SenderModel;

  factory SenderModel.fromJson(Map<String, dynamic> json) =>
      _$SenderModelFromJson(json);
}
