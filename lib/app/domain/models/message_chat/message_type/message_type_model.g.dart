// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageTypeModel _$MessageTypeModelFromJson(Map<String, dynamic> json) =>
    _MessageTypeModel(
      code: (json['code'] as num?)?.toInt(),
      nombre: json['nombre'] as String?,
      id: json['id'] as String?,
      messageTypeId: json['messageTypeId'] as String?,
    );

Map<String, dynamic> _$MessageTypeModelToJson(_MessageTypeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'nombre': instance.nombre,
      'id': instance.id,
      'messageTypeId': instance.messageTypeId,
    };
