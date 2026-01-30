import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gw_sms/app/domain/models/message_chat/message_data/message_data_model.dart';

part 'message_chat_model.freezed.dart';
part 'message_chat_model.g.dart';

@freezed
abstract class MessageChatModel with _$MessageChatModel {
  factory MessageChatModel({
    List<MessageDataModel>? data,
  }) = _MessageChatModel;

  factory MessageChatModel.fromJson(Map<String, dynamic> json) =>
      _$MessageChatModelFromJson(json);
}
