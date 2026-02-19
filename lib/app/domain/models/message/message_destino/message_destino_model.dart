import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_destino_model.freezed.dart';
part 'message_destino_model.g.dart';

@freezed
abstract class MessageDestinoModel with _$MessageDestinoModel {
  factory MessageDestinoModel({
    String? numero,
    String? mensaje,
    bool? fichero,
    String? tipo,
  }) = _MessageDestinoModel;

  factory MessageDestinoModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDestinoModelFromJson(json);
}
