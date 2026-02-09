// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageUserModel _$MessageUserModelFromJson(Map<String, dynamic> json) =>
    _MessageUserModel(
      ci: _ciFromJson(json['ci']),
      nombreCompleto: json['nombreCompleto'] as String?,
      msPersonaId: (json['msPersonaId'] as num?)?.toInt(),
      funcionarioId: (json['funcionarioId'] as num?)?.toInt(),
      institucionId: (json['institucionId'] as num?)?.toInt(),
      oficinaId: (json['oficinaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageUserModelToJson(_MessageUserModel instance) =>
    <String, dynamic>{
      'ci': instance.ci,
      'nombreCompleto': instance.nombreCompleto,
      'msPersonaId': instance.msPersonaId,
      'funcionarioId': instance.funcionarioId,
      'institucionId': instance.institucionId,
      'oficinaId': instance.oficinaId,
    };
