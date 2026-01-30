// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageChatModel _$MessageChatModelFromJson(Map<String, dynamic> json) =>
    _MessageChatModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MessageDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageChatModelToJson(_MessageChatModel instance) =>
    <String, dynamic>{'data': instance.data};
