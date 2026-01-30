import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_data_aditional/message_data_aditional_model.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_type/message_type_model.dart';
import 'package:gw_sms/app/domain/models/message_chat/sender/sender_model.dart';

part 'message_response_model.freezed.dart';
part 'message_response_model.g.dart';

@freezed
abstract class MessageResponseModel with _$MessageResponseModel {
  factory MessageResponseModel({
    DateTime? updatedAt,
    DateTime? createdAt,
    String? message,
    bool? visto,
    bool? multimedia,
    SenderModel? sender,
    bool? esCliente,
    String? appChatId,
    MessageTypeModel? messageType,
    MessageDataAditionalModel? dataAdicional,
    String? id,
    String? thumbnailFile,
    String? urlFile,
    dynamic autoMessage,
  }) = _MessageResponseModel;

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);
}
