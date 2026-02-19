// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_destino_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageDestinoModel {

 String? get numero; String? get mensaje; bool? get fichero; String? get tipo;
/// Create a copy of MessageDestinoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageDestinoModelCopyWith<MessageDestinoModel> get copyWith => _$MessageDestinoModelCopyWithImpl<MessageDestinoModel>(this as MessageDestinoModel, _$identity);

  /// Serializes this MessageDestinoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageDestinoModel&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.mensaje, mensaje) || other.mensaje == mensaje)&&(identical(other.fichero, fichero) || other.fichero == fichero)&&(identical(other.tipo, tipo) || other.tipo == tipo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numero,mensaje,fichero,tipo);

@override
String toString() {
  return 'MessageDestinoModel(numero: $numero, mensaje: $mensaje, fichero: $fichero, tipo: $tipo)';
}


}

/// @nodoc
abstract mixin class $MessageDestinoModelCopyWith<$Res>  {
  factory $MessageDestinoModelCopyWith(MessageDestinoModel value, $Res Function(MessageDestinoModel) _then) = _$MessageDestinoModelCopyWithImpl;
@useResult
$Res call({
 String? numero, String? mensaje, bool? fichero, String? tipo
});




}
/// @nodoc
class _$MessageDestinoModelCopyWithImpl<$Res>
    implements $MessageDestinoModelCopyWith<$Res> {
  _$MessageDestinoModelCopyWithImpl(this._self, this._then);

  final MessageDestinoModel _self;
  final $Res Function(MessageDestinoModel) _then;

/// Create a copy of MessageDestinoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? numero = freezed,Object? mensaje = freezed,Object? fichero = freezed,Object? tipo = freezed,}) {
  return _then(_self.copyWith(
numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String?,mensaje: freezed == mensaje ? _self.mensaje : mensaje // ignore: cast_nullable_to_non_nullable
as String?,fichero: freezed == fichero ? _self.fichero : fichero // ignore: cast_nullable_to_non_nullable
as bool?,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageDestinoModel].
extension MessageDestinoModelPatterns on MessageDestinoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageDestinoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageDestinoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageDestinoModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageDestinoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageDestinoModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageDestinoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? numero,  String? mensaje,  bool? fichero,  String? tipo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageDestinoModel() when $default != null:
return $default(_that.numero,_that.mensaje,_that.fichero,_that.tipo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? numero,  String? mensaje,  bool? fichero,  String? tipo)  $default,) {final _that = this;
switch (_that) {
case _MessageDestinoModel():
return $default(_that.numero,_that.mensaje,_that.fichero,_that.tipo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? numero,  String? mensaje,  bool? fichero,  String? tipo)?  $default,) {final _that = this;
switch (_that) {
case _MessageDestinoModel() when $default != null:
return $default(_that.numero,_that.mensaje,_that.fichero,_that.tipo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageDestinoModel implements MessageDestinoModel {
   _MessageDestinoModel({this.numero, this.mensaje, this.fichero, this.tipo});
  factory _MessageDestinoModel.fromJson(Map<String, dynamic> json) => _$MessageDestinoModelFromJson(json);

@override final  String? numero;
@override final  String? mensaje;
@override final  bool? fichero;
@override final  String? tipo;

/// Create a copy of MessageDestinoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageDestinoModelCopyWith<_MessageDestinoModel> get copyWith => __$MessageDestinoModelCopyWithImpl<_MessageDestinoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageDestinoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageDestinoModel&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.mensaje, mensaje) || other.mensaje == mensaje)&&(identical(other.fichero, fichero) || other.fichero == fichero)&&(identical(other.tipo, tipo) || other.tipo == tipo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numero,mensaje,fichero,tipo);

@override
String toString() {
  return 'MessageDestinoModel(numero: $numero, mensaje: $mensaje, fichero: $fichero, tipo: $tipo)';
}


}

/// @nodoc
abstract mixin class _$MessageDestinoModelCopyWith<$Res> implements $MessageDestinoModelCopyWith<$Res> {
  factory _$MessageDestinoModelCopyWith(_MessageDestinoModel value, $Res Function(_MessageDestinoModel) _then) = __$MessageDestinoModelCopyWithImpl;
@override @useResult
$Res call({
 String? numero, String? mensaje, bool? fichero, String? tipo
});




}
/// @nodoc
class __$MessageDestinoModelCopyWithImpl<$Res>
    implements _$MessageDestinoModelCopyWith<$Res> {
  __$MessageDestinoModelCopyWithImpl(this._self, this._then);

  final _MessageDestinoModel _self;
  final $Res Function(_MessageDestinoModel) _then;

/// Create a copy of MessageDestinoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numero = freezed,Object? mensaje = freezed,Object? fichero = freezed,Object? tipo = freezed,}) {
  return _then(_MessageDestinoModel(
numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String?,mensaje: freezed == mensaje ? _self.mensaje : mensaje // ignore: cast_nullable_to_non_nullable
as String?,fichero: freezed == fichero ? _self.fichero : fichero // ignore: cast_nullable_to_non_nullable
as bool?,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
