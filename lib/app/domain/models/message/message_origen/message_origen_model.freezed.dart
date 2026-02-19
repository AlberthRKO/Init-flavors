// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_origen_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageOrigenModel {

 String? get aplicacion; String? get modulo; String? get numero; MessageUsuarioModel? get usuario;
/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageOrigenModelCopyWith<MessageOrigenModel> get copyWith => _$MessageOrigenModelCopyWithImpl<MessageOrigenModel>(this as MessageOrigenModel, _$identity);

  /// Serializes this MessageOrigenModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageOrigenModel&&(identical(other.aplicacion, aplicacion) || other.aplicacion == aplicacion)&&(identical(other.modulo, modulo) || other.modulo == modulo)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.usuario, usuario) || other.usuario == usuario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aplicacion,modulo,numero,usuario);

@override
String toString() {
  return 'MessageOrigenModel(aplicacion: $aplicacion, modulo: $modulo, numero: $numero, usuario: $usuario)';
}


}

/// @nodoc
abstract mixin class $MessageOrigenModelCopyWith<$Res>  {
  factory $MessageOrigenModelCopyWith(MessageOrigenModel value, $Res Function(MessageOrigenModel) _then) = _$MessageOrigenModelCopyWithImpl;
@useResult
$Res call({
 String? aplicacion, String? modulo, String? numero, MessageUsuarioModel? usuario
});


$MessageUsuarioModelCopyWith<$Res>? get usuario;

}
/// @nodoc
class _$MessageOrigenModelCopyWithImpl<$Res>
    implements $MessageOrigenModelCopyWith<$Res> {
  _$MessageOrigenModelCopyWithImpl(this._self, this._then);

  final MessageOrigenModel _self;
  final $Res Function(MessageOrigenModel) _then;

/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aplicacion = freezed,Object? modulo = freezed,Object? numero = freezed,Object? usuario = freezed,}) {
  return _then(_self.copyWith(
aplicacion: freezed == aplicacion ? _self.aplicacion : aplicacion // ignore: cast_nullable_to_non_nullable
as String?,modulo: freezed == modulo ? _self.modulo : modulo // ignore: cast_nullable_to_non_nullable
as String?,numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String?,usuario: freezed == usuario ? _self.usuario : usuario // ignore: cast_nullable_to_non_nullable
as MessageUsuarioModel?,
  ));
}
/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageUsuarioModelCopyWith<$Res>? get usuario {
    if (_self.usuario == null) {
    return null;
  }

  return $MessageUsuarioModelCopyWith<$Res>(_self.usuario!, (value) {
    return _then(_self.copyWith(usuario: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessageOrigenModel].
extension MessageOrigenModelPatterns on MessageOrigenModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageOrigenModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageOrigenModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageOrigenModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageOrigenModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageOrigenModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageOrigenModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? aplicacion,  String? modulo,  String? numero,  MessageUsuarioModel? usuario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageOrigenModel() when $default != null:
return $default(_that.aplicacion,_that.modulo,_that.numero,_that.usuario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? aplicacion,  String? modulo,  String? numero,  MessageUsuarioModel? usuario)  $default,) {final _that = this;
switch (_that) {
case _MessageOrigenModel():
return $default(_that.aplicacion,_that.modulo,_that.numero,_that.usuario);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? aplicacion,  String? modulo,  String? numero,  MessageUsuarioModel? usuario)?  $default,) {final _that = this;
switch (_that) {
case _MessageOrigenModel() when $default != null:
return $default(_that.aplicacion,_that.modulo,_that.numero,_that.usuario);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageOrigenModel implements MessageOrigenModel {
   _MessageOrigenModel({this.aplicacion, this.modulo, this.numero, this.usuario});
  factory _MessageOrigenModel.fromJson(Map<String, dynamic> json) => _$MessageOrigenModelFromJson(json);

@override final  String? aplicacion;
@override final  String? modulo;
@override final  String? numero;
@override final  MessageUsuarioModel? usuario;

/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageOrigenModelCopyWith<_MessageOrigenModel> get copyWith => __$MessageOrigenModelCopyWithImpl<_MessageOrigenModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageOrigenModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageOrigenModel&&(identical(other.aplicacion, aplicacion) || other.aplicacion == aplicacion)&&(identical(other.modulo, modulo) || other.modulo == modulo)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.usuario, usuario) || other.usuario == usuario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aplicacion,modulo,numero,usuario);

@override
String toString() {
  return 'MessageOrigenModel(aplicacion: $aplicacion, modulo: $modulo, numero: $numero, usuario: $usuario)';
}


}

/// @nodoc
abstract mixin class _$MessageOrigenModelCopyWith<$Res> implements $MessageOrigenModelCopyWith<$Res> {
  factory _$MessageOrigenModelCopyWith(_MessageOrigenModel value, $Res Function(_MessageOrigenModel) _then) = __$MessageOrigenModelCopyWithImpl;
@override @useResult
$Res call({
 String? aplicacion, String? modulo, String? numero, MessageUsuarioModel? usuario
});


@override $MessageUsuarioModelCopyWith<$Res>? get usuario;

}
/// @nodoc
class __$MessageOrigenModelCopyWithImpl<$Res>
    implements _$MessageOrigenModelCopyWith<$Res> {
  __$MessageOrigenModelCopyWithImpl(this._self, this._then);

  final _MessageOrigenModel _self;
  final $Res Function(_MessageOrigenModel) _then;

/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aplicacion = freezed,Object? modulo = freezed,Object? numero = freezed,Object? usuario = freezed,}) {
  return _then(_MessageOrigenModel(
aplicacion: freezed == aplicacion ? _self.aplicacion : aplicacion // ignore: cast_nullable_to_non_nullable
as String?,modulo: freezed == modulo ? _self.modulo : modulo // ignore: cast_nullable_to_non_nullable
as String?,numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String?,usuario: freezed == usuario ? _self.usuario : usuario // ignore: cast_nullable_to_non_nullable
as MessageUsuarioModel?,
  ));
}

/// Create a copy of MessageOrigenModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageUsuarioModelCopyWith<$Res>? get usuario {
    if (_self.usuario == null) {
    return null;
  }

  return $MessageUsuarioModelCopyWith<$Res>(_self.usuario!, (value) {
    return _then(_self.copyWith(usuario: value));
  });
}
}

// dart format on
