// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      messageId: json['messageId'] as String?,
      chatId: json['chatId'] as String?,
      message: json['message'] as String?,
      app: json['app'] as String?,
      user: json['user'] == null
          ? null
          : MessageUserModel.fromJson(json['user'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      mode: json['mode'] as String?,
      messageType: (json['messageType'] as num?)?.toInt(),
      status: _statusFromJson(json['status']),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isEntregado: json['isEntregado'] as bool? ?? false,
      isEnviando: json['isEnviando'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'chatId': instance.chatId,
      'message': instance.message,
      'app': instance.app,
      'user': instance.user,
      'phone': instance.phone,
      'mode': instance.mode,
      'messageType': instance.messageType,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isEntregado': instance.isEntregado,
      'isEnviando': instance.isEnviando,
    };
