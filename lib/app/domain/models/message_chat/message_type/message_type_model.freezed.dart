// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageTypeModel {

 int? get code; String? get nombre; String? get id; String? get messageTypeId;
/// Create a copy of MessageTypeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageTypeModelCopyWith<MessageTypeModel> get copyWith => _$MessageTypeModelCopyWithImpl<MessageTypeModel>(this as MessageTypeModel, _$identity);

  /// Serializes this MessageTypeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageTypeModel&&(identical(other.code, code) || other.code == code)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.id, id) || other.id == id)&&(identical(other.messageTypeId, messageTypeId) || other.messageTypeId == messageTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,nombre,id,messageTypeId);

@override
String toString() {
  return 'MessageTypeModel(code: $code, nombre: $nombre, id: $id, messageTypeId: $messageTypeId)';
}


}

/// @nodoc
abstract mixin class $MessageTypeModelCopyWith<$Res>  {
  factory $MessageTypeModelCopyWith(MessageTypeModel value, $Res Function(MessageTypeModel) _then) = _$MessageTypeModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? nombre, String? id, String? messageTypeId
});




}
/// @nodoc
class _$MessageTypeModelCopyWithImpl<$Res>
    implements $MessageTypeModelCopyWith<$Res> {
  _$MessageTypeModelCopyWithImpl(this._self, this._then);

  final MessageTypeModel _self;
  final $Res Function(MessageTypeModel) _then;

/// Create a copy of MessageTypeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? nombre = freezed,Object? id = freezed,Object? messageTypeId = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,messageTypeId: freezed == messageTypeId ? _self.messageTypeId : messageTypeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageTypeModel].
extension MessageTypeModelPatterns on MessageTypeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageTypeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageTypeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageTypeModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageTypeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageTypeModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageTypeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? nombre,  String? id,  String? messageTypeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageTypeModel() when $default != null:
return $default(_that.code,_that.nombre,_that.id,_that.messageTypeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? nombre,  String? id,  String? messageTypeId)  $default,) {final _that = this;
switch (_that) {
case _MessageTypeModel():
return $default(_that.code,_that.nombre,_that.id,_that.messageTypeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? nombre,  String? id,  String? messageTypeId)?  $default,) {final _that = this;
switch (_that) {
case _MessageTypeModel() when $default != null:
return $default(_that.code,_that.nombre,_that.id,_that.messageTypeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageTypeModel implements MessageTypeModel {
   _MessageTypeModel({this.code, this.nombre, this.id, this.messageTypeId});
  factory _MessageTypeModel.fromJson(Map<String, dynamic> json) => _$MessageTypeModelFromJson(json);

@override final  int? code;
@override final  String? nombre;
@override final  String? id;
@override final  String? messageTypeId;

/// Create a copy of MessageTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageTypeModelCopyWith<_MessageTypeModel> get copyWith => __$MessageTypeModelCopyWithImpl<_MessageTypeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageTypeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageTypeModel&&(identical(other.code, code) || other.code == code)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.id, id) || other.id == id)&&(identical(other.messageTypeId, messageTypeId) || other.messageTypeId == messageTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,nombre,id,messageTypeId);

@override
String toString() {
  return 'MessageTypeModel(code: $code, nombre: $nombre, id: $id, messageTypeId: $messageTypeId)';
}


}

/// @nodoc
abstract mixin class _$MessageTypeModelCopyWith<$Res> implements $MessageTypeModelCopyWith<$Res> {
  factory _$MessageTypeModelCopyWith(_MessageTypeModel value, $Res Function(_MessageTypeModel) _then) = __$MessageTypeModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? nombre, String? id, String? messageTypeId
});




}
/// @nodoc
class __$MessageTypeModelCopyWithImpl<$Res>
    implements _$MessageTypeModelCopyWith<$Res> {
  __$MessageTypeModelCopyWithImpl(this._self, this._then);

  final _MessageTypeModel _self;
  final $Res Function(_MessageTypeModel) _then;

/// Create a copy of MessageTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? nombre = freezed,Object? id = freezed,Object? messageTypeId = freezed,}) {
  return _then(_MessageTypeModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,messageTypeId: freezed == messageTypeId ? _self.messageTypeId : messageTypeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
