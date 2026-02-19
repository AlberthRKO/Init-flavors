// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_destino_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageDestinoModel _$MessageDestinoModelFromJson(Map<String, dynamic> json) =>
    _MessageDestinoModel(
      numero: json['numero'] as String?,
      mensaje: json['mensaje'] as String?,
      fichero: json['fichero'] as bool?,
      tipo: json['tipo'] as String?,
    );

Map<String, dynamic> _$MessageDestinoModelToJson(
  _MessageDestinoModel instance,
) => <String, dynamic>{
  'numero': instance.numero,
  'mensaje': instance.mensaje,
  'fichero': instance.fichero,
  'tipo': instance.tipo,
};
