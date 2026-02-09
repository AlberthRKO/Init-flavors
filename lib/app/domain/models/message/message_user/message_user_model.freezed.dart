// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageUserModel {

@JsonKey(fromJson: _ciFromJson) String? get ci; String? get nombreCompleto; int? get msPersonaId; int? get funcionarioId; int? get institucionId; int? get oficinaId;
/// Create a copy of MessageUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageUserModelCopyWith<MessageUserModel> get copyWith => _$MessageUserModelCopyWithImpl<MessageUserModel>(this as MessageUserModel, _$identity);

  /// Serializes this MessageUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageUserModel&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.msPersonaId, msPersonaId) || other.msPersonaId == msPersonaId)&&(identical(other.funcionarioId, funcionarioId) || other.funcionarioId == funcionarioId)&&(identical(other.institucionId, institucionId) || other.institucionId == institucionId)&&(identical(other.oficinaId, oficinaId) || other.oficinaId == oficinaId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ci,nombreCompleto,msPersonaId,funcionarioId,institucionId,oficinaId);

@override
String toString() {
  return 'MessageUserModel(ci: $ci, nombreCompleto: $nombreCompleto, msPersonaId: $msPersonaId, funcionarioId: $funcionarioId, institucionId: $institucionId, oficinaId: $oficinaId)';
}


}

/// @nodoc
abstract mixin class $MessageUserModelCopyWith<$Res>  {
  factory $MessageUserModelCopyWith(MessageUserModel value, $Res Function(MessageUserModel) _then) = _$MessageUserModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _ciFromJson) String? ci, String? nombreCompleto, int? msPersonaId, int? funcionarioId, int? institucionId, int? oficinaId
});




}
/// @nodoc
class _$MessageUserModelCopyWithImpl<$Res>
    implements $MessageUserModelCopyWith<$Res> {
  _$MessageUserModelCopyWithImpl(this._self, this._then);

  final MessageUserModel _self;
  final $Res Function(MessageUserModel) _then;

/// Create a copy of MessageUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ci = freezed,Object? nombreCompleto = freezed,Object? msPersonaId = freezed,Object? funcionarioId = freezed,Object? institucionId = freezed,Object? oficinaId = freezed,}) {
  return _then(_self.copyWith(
ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,msPersonaId: freezed == msPersonaId ? _self.msPersonaId : msPersonaId // ignore: cast_nullable_to_non_nullable
as int?,funcionarioId: freezed == funcionarioId ? _self.funcionarioId : funcionarioId // ignore: cast_nullable_to_non_nullable
as int?,institucionId: freezed == institucionId ? _self.institucionId : institucionId // ignore: cast_nullable_to_non_nullable
as int?,oficinaId: freezed == oficinaId ? _self.oficinaId : oficinaId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageUserModel].
extension MessageUserModelPatterns on MessageUserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageUserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageUserModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageUserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageUserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _ciFromJson)  String? ci,  String? nombreCompleto,  int? msPersonaId,  int? funcionarioId,  int? institucionId,  int? oficinaId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageUserModel() when $default != null:
return $default(_that.ci,_that.nombreCompleto,_that.msPersonaId,_that.funcionarioId,_that.institucionId,_that.oficinaId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _ciFromJson)  String? ci,  String? nombreCompleto,  int? msPersonaId,  int? funcionarioId,  int? institucionId,  int? oficinaId)  $default,) {final _that = this;
switch (_that) {
case _MessageUserModel():
return $default(_that.ci,_that.nombreCompleto,_that.msPersonaId,_that.funcionarioId,_that.institucionId,_that.oficinaId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _ciFromJson)  String? ci,  String? nombreCompleto,  int? msPersonaId,  int? funcionarioId,  int? institucionId,  int? oficinaId)?  $default,) {final _that = this;
switch (_that) {
case _MessageUserModel() when $default != null:
return $default(_that.ci,_that.nombreCompleto,_that.msPersonaId,_that.funcionarioId,_that.institucionId,_that.oficinaId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageUserModel implements MessageUserModel {
   _MessageUserModel({@JsonKey(fromJson: _ciFromJson) this.ci, this.nombreCompleto, this.msPersonaId, this.funcionarioId, this.institucionId, this.oficinaId});
  factory _MessageUserModel.fromJson(Map<String, dynamic> json) => _$MessageUserModelFromJson(json);

@override@JsonKey(fromJson: _ciFromJson) final  String? ci;
@override final  String? nombreCompleto;
@override final  int? msPersonaId;
@override final  int? funcionarioId;
@override final  int? institucionId;
@override final  int? oficinaId;

/// Create a copy of MessageUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageUserModelCopyWith<_MessageUserModel> get copyWith => __$MessageUserModelCopyWithImpl<_MessageUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageUserModel&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.msPersonaId, msPersonaId) || other.msPersonaId == msPersonaId)&&(identical(other.funcionarioId, funcionarioId) || other.funcionarioId == funcionarioId)&&(identical(other.institucionId, institucionId) || other.institucionId == institucionId)&&(identical(other.oficinaId, oficinaId) || other.oficinaId == oficinaId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ci,nombreCompleto,msPersonaId,funcionarioId,institucionId,oficinaId);

@override
String toString() {
  return 'MessageUserModel(ci: $ci, nombreCompleto: $nombreCompleto, msPersonaId: $msPersonaId, funcionarioId: $funcionarioId, institucionId: $institucionId, oficinaId: $oficinaId)';
}


}

/// @nodoc
abstract mixin class _$MessageUserModelCopyWith<$Res> implements $MessageUserModelCopyWith<$Res> {
  factory _$MessageUserModelCopyWith(_MessageUserModel value, $Res Function(_MessageUserModel) _then) = __$MessageUserModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _ciFromJson) String? ci, String? nombreCompleto, int? msPersonaId, int? funcionarioId, int? institucionId, int? oficinaId
});




}
/// @nodoc
class __$MessageUserModelCopyWithImpl<$Res>
    implements _$MessageUserModelCopyWith<$Res> {
  __$MessageUserModelCopyWithImpl(this._self, this._then);

  final _MessageUserModel _self;
  final $Res Function(_MessageUserModel) _then;

/// Create a copy of MessageUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ci = freezed,Object? nombreCompleto = freezed,Object? msPersonaId = freezed,Object? funcionarioId = freezed,Object? institucionId = freezed,Object? oficinaId = freezed,}) {
  return _then(_MessageUserModel(
ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,msPersonaId: freezed == msPersonaId ? _self.msPersonaId : msPersonaId // ignore: cast_nullable_to_non_nullable
as int?,funcionarioId: freezed == funcionarioId ? _self.funcionarioId : funcionarioId // ignore: cast_nullable_to_non_nullable
as int?,institucionId: freezed == institucionId ? _self.institucionId : institucionId // ignore: cast_nullable_to_non_nullable
as int?,oficinaId: freezed == oficinaId ? _self.oficinaId : oficinaId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
