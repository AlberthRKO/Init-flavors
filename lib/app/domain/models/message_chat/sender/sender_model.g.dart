// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SenderModel _$SenderModelFromJson(Map<String, dynamic> json) => _SenderModel(
  nombreCompleto: json['nombreCompleto'] as String?,
  ci: json['ci'] as String?,
  msPersonaId: (json['msPersonaId'] as num?)?.toInt(),
  funcionarioId: (json['funcionarioId'] as num?)?.toInt(),
  departamentoId: (json['departamentoId'] as num?)?.toInt(),
  oficinaId: (json['oficinaId'] as num?)?.toInt(),
  oficina: json['oficina'] as String?,
);

Map<String, dynamic> _$SenderModelToJson(_SenderModel instance) =>
    <String, dynamic>{
      'nombreCompleto': instance.nombreCompleto,
      'ci': instance.ci,
      'msPersonaId': instance.msPersonaId,
      'funcionarioId': instance.funcionarioId,
      'departamentoId': instance.departamentoId,
      'oficinaId': instance.oficinaId,
      'oficina': instance.oficina,
    };
