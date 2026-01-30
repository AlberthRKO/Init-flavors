// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageResponseModel _$MessageResponseModelFromJson(
  Map<String, dynamic> json,
) => _MessageResponseModel(
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  message: json['message'] as String?,
  visto: json['visto'] as bool?,
  multimedia: json['multimedia'] as bool?,
  sender: json['sender'] == null
      ? null
      : SenderModel.fromJson(json['sender'] as Map<String, dynamic>),
  esCliente: json['esCliente'] as bool?,
  appChatId: json['appChatId'] as String?,
  messageType: json['messageType'] == null
      ? null
      : MessageTypeModel.fromJson(json['messageType'] as Map<String, dynamic>),
  dataAdicional: json['dataAdicional'] == null
      ? null
      : MessageDataAditionalModel.fromJson(
          json['dataAdicional'] as Map<String, dynamic>,
        ),
  id: json['id'] as String?,
  thumbnailFile: json['thumbnailFile'] as String?,
  urlFile: json['urlFile'] as String?,
  autoMessage: json['autoMessage'],
);

Map<String, dynamic> _$MessageResponseModelToJson(
  _MessageResponseModel instance,
) => <String, dynamic>{
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'message': instance.message,
  'visto': instance.visto,
  'multimedia': instance.multimedia,
  'sender': instance.sender,
  'esCliente': instance.esCliente,
  'appChatId': instance.appChatId,
  'messageType': instance.messageType,
  'dataAdicional': instance.dataAdicional,
  'id': instance.id,
  'thumbnailFile': instance.thumbnailFile,
  'urlFile': instance.urlFile,
  'autoMessage': instance.autoMessage,
};
