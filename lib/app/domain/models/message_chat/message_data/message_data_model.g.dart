// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageDataModel _$MessageDataModelFromJson(
  Map<String, dynamic> json,
) => _MessageDataModel(
  roomId: (json['roomId'] as num?)?.toInt(),
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
  chatId: json['chatId'] as String?,
  id: json['id'] as String?,
  messageType: json['messageType'] == null
      ? null
      : MessageTypeModel.fromJson(json['messageType'] as Map<String, dynamic>),
  response: json['response'] == null
      ? null
      : MessageResponseModel.fromJson(json['response'] as Map<String, dynamic>),
  dataAdicional: json['dataAdicional'] == null
      ? null
      : MessageDataAditionalModel.fromJson(
          json['dataAdicional'] as Map<String, dynamic>,
        ),
  thumbnailFile: json['thumbnailFile'] as String?,
  urlFile: json['urlFile'] as String?,
  autoMessage: json['autoMessage'],
  isEntregado: json['isEntregado'] as bool? ?? false,
  isEnviando: json['isEnviando'] as bool? ?? false,
);

Map<String, dynamic> _$MessageDataModelToJson(_MessageDataModel instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'message': instance.message,
      'visto': instance.visto,
      'multimedia': instance.multimedia,
      'sender': instance.sender,
      'esCliente': instance.esCliente,
      'appChatId': instance.appChatId,
      'chatId': instance.chatId,
      'id': instance.id,
      'messageType': instance.messageType,
      'response': instance.response,
      'dataAdicional': instance.dataAdicional,
      'thumbnailFile': instance.thumbnailFile,
      'urlFile': instance.urlFile,
      'autoMessage': instance.autoMessage,
      'isEntregado': instance.isEntregado,
      'isEnviando': instance.isEnviando,
    };
