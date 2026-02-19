// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_usuario_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageUsuarioModel {

 String? get ci; String? get nombreCompleto;
/// Create a copy of MessageUsuarioModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageUsuarioModelCopyWith<MessageUsuarioModel> get copyWith => _$MessageUsuarioModelCopyWithImpl<MessageUsuarioModel>(this as MessageUsuarioModel, _$identity);

  /// Serializes this MessageUsuarioModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageUsuarioModel&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ci,nombreCompleto);

@override
String toString() {
  return 'MessageUsuarioModel(ci: $ci, nombreCompleto: $nombreCompleto)';
}


}

/// @nodoc
abstract mixin class $MessageUsuarioModelCopyWith<$Res>  {
  factory $MessageUsuarioModelCopyWith(MessageUsuarioModel value, $Res Function(MessageUsuarioModel) _then) = _$MessageUsuarioModelCopyWithImpl;
@useResult
$Res call({
 String? ci, String? nombreCompleto
});




}
/// @nodoc
class _$MessageUsuarioModelCopyWithImpl<$Res>
    implements $MessageUsuarioModelCopyWith<$Res> {
  _$MessageUsuarioModelCopyWithImpl(this._self, this._then);

  final MessageUsuarioModel _self;
  final $Res Function(MessageUsuarioModel) _then;

/// Create a copy of MessageUsuarioModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ci = freezed,Object? nombreCompleto = freezed,}) {
  return _then(_self.copyWith(
ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageUsuarioModel].
extension MessageUsuarioModelPatterns on MessageUsuarioModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageUsuarioModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageUsuarioModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageUsuarioModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageUsuarioModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageUsuarioModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageUsuarioModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ci,  String? nombreCompleto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageUsuarioModel() when $default != null:
return $default(_that.ci,_that.nombreCompleto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ci,  String? nombreCompleto)  $default,) {final _that = this;
switch (_that) {
case _MessageUsuarioModel():
return $default(_that.ci,_that.nombreCompleto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ci,  String? nombreCompleto)?  $default,) {final _that = this;
switch (_that) {
case _MessageUsuarioModel() when $default != null:
return $default(_that.ci,_that.nombreCompleto);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageUsuarioModel implements MessageUsuarioModel {
   _MessageUsuarioModel({this.ci, this.nombreCompleto});
  factory _MessageUsuarioModel.fromJson(Map<String, dynamic> json) => _$MessageUsuarioModelFromJson(json);

@override final  String? ci;
@override final  String? nombreCompleto;

/// Create a copy of MessageUsuarioModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageUsuarioModelCopyWith<_MessageUsuarioModel> get copyWith => __$MessageUsuarioModelCopyWithImpl<_MessageUsuarioModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageUsuarioModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageUsuarioModel&&(identical(other.ci, ci) || other.ci == ci)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ci,nombreCompleto);

@override
String toString() {
  return 'MessageUsuarioModel(ci: $ci, nombreCompleto: $nombreCompleto)';
}


}

/// @nodoc
abstract mixin class _$MessageUsuarioModelCopyWith<$Res> implements $MessageUsuarioModelCopyWith<$Res> {
  factory _$MessageUsuarioModelCopyWith(_MessageUsuarioModel value, $Res Function(_MessageUsuarioModel) _then) = __$MessageUsuarioModelCopyWithImpl;
@override @useResult
$Res call({
 String? ci, String? nombreCompleto
});




}
/// @nodoc
class __$MessageUsuarioModelCopyWithImpl<$Res>
    implements _$MessageUsuarioModelCopyWith<$Res> {
  __$MessageUsuarioModelCopyWithImpl(this._self, this._then);

  final _MessageUsuarioModel _self;
  final $Res Function(_MessageUsuarioModel) _then;

/// Create a copy of MessageUsuarioModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ci = freezed,Object? nombreCompleto = freezed,}) {
  return _then(_MessageUsuarioModel(
ci: freezed == ci ? _self.ci : ci // ignore: cast_nullable_to_non_nullable
as String?,nombreCompleto: freezed == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
