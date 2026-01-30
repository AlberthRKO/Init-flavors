// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sender_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SenderModel {

 String? get nombreCompleto; String? get ci; int? get msPersonaId; int? get funcionarioId; int? get departamentoId; int? get oficinaId; String? get oficina;
/// Create a copy of SenderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SenderModelCopyWith<SenderModel> get copyWith => _$SenderModelCopyWithImpl<SenderModel>(this as SenderModel, _$identity);

  /// Serializes this SenderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SenderModel&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.msPersonaId, msPersonaId) || other.msPersonaId == msPersonaId)&&(identical(other.funcionarioId, funcionarioId) || other.funcionarioId == funcionarioId)&&(identical(other.departamentoId, departamentoId) || other.departamentoId == departamentoId)&&(identical(other.oficinaId, oficinaId) || other.oficinaId == oficinaId)&&(identical(other.oficina, oficina) || other.oficina == oficina));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreCompleto,ci,msPersonaId,funcionarioId,departamentoId,oficinaId,oficina);

@override
String toString() {
  return 'SenderModel(nombreCompleto: $nombreCompleto, ci: $ci, msPersonaId: $msPersonaId, funcionarioId: $funcionarioId, departamentoId: $departamentoId, oficinaId: $oficinaId, oficina: $oficina)';
}


}

/// @nodoc
abstract mixin class $SenderModelCopyWith<$Res>  {
  factory $SenderModelCopyWith(SenderModel value, $Res Function(SenderModel) _then) = _$SenderModelCopyWithImpl;
@useResult
$Res call({
 String? nombreCompleto, String? ci, int? msPersonaId, int? funcionarioId, int? departamentoId, int? oficinaId, String? oficina
});




}
/// @nodoc
class _$SenderModelCopyWithImpl<$Res>
    implements $SenderModelCopyWith<$Res> {
  _$SenderModelCopyWithImpl(this._self, this._then);

  final SenderModel _self;
  final $Res Function(SenderModel) _then;

/// Create a copy of SenderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombreCompleto = freezed,Object? ci = freezed,Object? msPersonaId = freezed,Object? funcionarioId = freezed,Object? departamentoId = freezed,Object? oficinaId = freezed,Object? oficina = freezed,}) {
  return _then(_self.copyWith(
nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,msPersonaId: freezed == msPersonaId ? _self.msPersonaId : msPersonaId // ignore: cast_nullable_to_non_nullable
as int?,funcionarioId: freezed == funcionarioId ? _self.funcionarioId : funcionarioId // ignore: cast_nullable_to_non_nullable
as int?,departamentoId: freezed == departamentoId ? _self.departamentoId : departamentoId // ignore: cast_nullable_to_non_nullable
as int?,oficinaId: freezed == oficinaId ? _self.oficinaId : oficinaId // ignore: cast_nullable_to_non_nullable
as int?,oficina: freezed == oficina ? _self.oficina : oficina // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SenderModel].
extension SenderModelPatterns on SenderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SenderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SenderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SenderModel value)  $default,){
final _that = this;
switch (_that) {
case _SenderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SenderModel value)?  $default,){
final _that = this;
switch (_that) {
case _SenderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nombreCompleto,  String? ci,  int? msPersonaId,  int? funcionarioId,  int? departamentoId,  int? oficinaId,  String? oficina)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SenderModel() when $default != null:
return $default(_that.nombreCompleto,_that.ci,_that.msPersonaId,_that.funcionarioId,_that.departamentoId,_that.oficinaId,_that.oficina);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nombreCompleto,  String? ci,  int? msPersonaId,  int? funcionarioId,  int? departamentoId,  int? oficinaId,  String? oficina)  $default,) {final _that = this;
switch (_that) {
case _SenderModel():
return $default(_that.nombreCompleto,_that.ci,_that.msPersonaId,_that.funcionarioId,_that.departamentoId,_that.oficinaId,_that.oficina);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nombreCompleto,  String? ci,  int? msPersonaId,  int? funcionarioId,  int? departamentoId,  int? oficinaId,  String? oficina)?  $default,) {final _that = this;
switch (_that) {
case _SenderModel() when $default != null:
return $default(_that.nombreCompleto,_that.ci,_that.msPersonaId,_that.funcionarioId,_that.departamentoId,_that.oficinaId,_that.oficina);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SenderModel implements SenderModel {
   _SenderModel({this.nombreCompleto, this.ci, this.msPersonaId, this.funcionarioId, this.departamentoId, this.oficinaId, this.oficina});
  factory _SenderModel.fromJson(Map<String, dynamic> json) => _$SenderModelFromJson(json);

@override final  String? nombreCompleto;
@override final  String? ci;
@override final  int? msPersonaId;
@override final  int? funcionarioId;
@override final  int? departamentoId;
@override final  int? oficinaId;
@override final  String? oficina;

/// Create a copy of SenderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SenderModelCopyWith<_SenderModel> get copyWith => __$SenderModelCopyWithImpl<_SenderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SenderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SenderModel&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.msPersonaId, msPersonaId) || other.msPersonaId == msPersonaId)&&(identical(other.funcionarioId, funcionarioId) || other.funcionarioId == funcionarioId)&&(identical(other.departamentoId, departamentoId) || other.departamentoId == departamentoId)&&(identical(other.oficinaId, oficinaId) || other.oficinaId == oficinaId)&&(identical(other.oficina, oficina) || other.oficina == oficina));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreCompleto,ci,msPersonaId,funcionarioId,departamentoId,oficinaId,oficina);

@override
String toString() {
  return 'SenderModel(nombreCompleto: $nombreCompleto, ci: $ci, msPersonaId: $msPersonaId, funcionarioId: $funcionarioId, departamentoId: $departamentoId, oficinaId: $oficinaId, oficina: $oficina)';
}


}

/// @nodoc
abstract mixin class _$SenderModelCopyWith<$Res> implements $SenderModelCopyWith<$Res> {
  factory _$SenderModelCopyWith(_SenderModel value, $Res Function(_SenderModel) _then) = __$SenderModelCopyWithImpl;
@override @useResult
$Res call({
 String? nombreCompleto, String? ci, int? msPersonaId, int? funcionarioId, int? departamentoId, int? oficinaId, String? oficina
});




}
/// @nodoc
class __$SenderModelCopyWithImpl<$Res>
    implements _$SenderModelCopyWith<$Res> {
  __$SenderModelCopyWithImpl(this._self, this._then);

  final _SenderModel _self;
  final $Res Function(_SenderModel) _then;

/// Create a copy of SenderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombreCompleto = freezed,Object? ci = freezed,Object? msPersonaId = freezed,Object? funcionarioId = freezed,Object? departamentoId = freezed,Object? oficinaId = freezed,Object? oficina = freezed,}) {
  return _then(_SenderModel(
nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,msPersonaId: freezed == msPersonaId ? _self.msPersonaId : msPersonaId // ignore: cast_nullable_to_non_nullable
as int?,funcionarioId: freezed == funcionarioId ? _self.funcionarioId : funcionarioId // ignore: cast_nullable_to_non_nullable
as int?,departamentoId: freezed == departamentoId ? _self.departamentoId : departamentoId // ignore: cast_nullable_to_non_nullable
as int?,oficinaId: freezed == oficinaId ? _self.oficinaId : oficinaId // ignore: cast_nullable_to_non_nullable
as int?,oficina: freezed == oficina ? _self.oficina : oficina // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
