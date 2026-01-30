import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_data_aditional_model.freezed.dart';
part 'message_data_aditional_model.g.dart';

@freezed
abstract class MessageDataAditionalModel with _$MessageDataAditionalModel {
  factory MessageDataAditionalModel({
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? estado,
    String? tipo,
    int? totalEnviados,
    int? totalRecibidos,
    int? totalNoVistos,
    int? totalNoVistosCliente,
    String? chatId,
    DateTime? lastMessageAt,
    String? lastOperator,
    String? id,
  }) = _MessageDataAditionalModel;

  factory MessageDataAditionalModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDataAditionalModelFromJson(json);
}
