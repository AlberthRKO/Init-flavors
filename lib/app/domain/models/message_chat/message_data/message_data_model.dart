import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_data_aditional/message_data_aditional_model.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_response/message_response_model.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_type/message_type_model.dart';
import 'package:gw_sms/app/domain/models/message_chat/sender/sender_model.dart';

part 'message_data_model.freezed.dart';
part 'message_data_model.g.dart';

@freezed
abstract class MessageDataModel with _$MessageDataModel {
  factory MessageDataModel({
    int? roomId,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? message,
    bool? visto,
    bool? multimedia,
    SenderModel? sender,
    bool? esCliente,
    String? appChatId,
    String? chatId,
    String? id,
    MessageTypeModel? messageType,
    MessageResponseModel? response,
    MessageDataAditionalModel? dataAdicional,
    String? thumbnailFile,
    String? urlFile,
    dynamic autoMessage,
  }) = _MessageDataModel;

  factory MessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDataModelFromJson(json);
}
