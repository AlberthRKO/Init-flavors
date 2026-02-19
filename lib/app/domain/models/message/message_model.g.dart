// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['_id'] as String?,
      origen: json['origen'] == null
          ? null
          : MessageOrigenModel.fromJson(json['origen'] as Map<String, dynamic>),
      destino: json['destino'] == null
          ? null
          : MessageDestinoModel.fromJson(
              json['destino'] as Map<String, dynamic>,
            ),
      estado: json['estado'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'origen': instance.origen,
      'destino': instance.destino,
      'estado': instance.estado,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
