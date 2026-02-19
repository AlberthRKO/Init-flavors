// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_origen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageOrigenModel _$MessageOrigenModelFromJson(Map<String, dynamic> json) =>
    _MessageOrigenModel(
      aplicacion: json['aplicacion'] as String?,
      modulo: json['modulo'] as String?,
      numero: json['numero'] as String?,
      usuario: json['usuario'] == null
          ? null
          : MessageUsuarioModel.fromJson(
              json['usuario'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MessageOrigenModelToJson(_MessageOrigenModel instance) =>
    <String, dynamic>{
      'aplicacion': instance.aplicacion,
      'modulo': instance.modulo,
      'numero': instance.numero,
      'usuario': instance.usuario,
    };
