// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data_aditional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageDataAditionalModel _$MessageDataAditionalModelFromJson(
  Map<String, dynamic> json,
) => _MessageDataAditionalModel(
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  estado: json['estado'] as bool?,
  tipo: json['tipo'] as String?,
  totalEnviados: (json['totalEnviados'] as num?)?.toInt(),
  totalRecibidos: (json['totalRecibidos'] as num?)?.toInt(),
  totalNoVistos: (json['totalNoVistos'] as num?)?.toInt(),
  totalNoVistosCliente: (json['totalNoVistosCliente'] as num?)?.toInt(),
  chatId: json['chatId'] as String?,
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  lastOperator: json['lastOperator'] as String?,
  id: json['id'] as String?,
);

Map<String, dynamic> _$MessageDataAditionalModelToJson(
  _MessageDataAditionalModel instance,
) => <String, dynamic>{
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'estado': instance.estado,
  'tipo': instance.tipo,
  'totalEnviados': instance.totalEnviados,
  'totalRecibidos': instance.totalRecibidos,
  'totalNoVistos': instance.totalNoVistos,
  'totalNoVistosCliente': instance.totalNoVistosCliente,
  'chatId': instance.chatId,
  'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
  'lastOperator': instance.lastOperator,
  'id': instance.id,
};
