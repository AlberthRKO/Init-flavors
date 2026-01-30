// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageChatModel {

 List<MessageDataModel>? get data;
/// Create a copy of MessageChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageChatModelCopyWith<MessageChatModel> get copyWith => _$MessageChatModelCopyWithImpl<MessageChatModel>(this as MessageChatModel, _$identity);

  /// Serializes this MessageChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageChatModel&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'MessageChatModel(data: $data)';
}


}

/// @nodoc
abstract mixin class $MessageChatModelCopyWith<$Res>  {
  factory $MessageChatModelCopyWith(MessageChatModel value, $Res Function(MessageChatModel) _then) = _$MessageChatModelCopyWithImpl;
@useResult
$Res call({
 List<MessageDataModel>? data
});




}
/// @nodoc
class _$MessageChatModelCopyWithImpl<$Res>
    implements $MessageChatModelCopyWith<$Res> {
  _$MessageChatModelCopyWithImpl(this._self, this._then);

  final MessageChatModel _self;
  final $Res Function(MessageChatModel) _then;

/// Create a copy of MessageChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MessageDataModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageChatModel].
extension MessageChatModelPatterns on MessageChatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageChatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageChatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageChatModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageChatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageChatModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageChatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MessageDataModel>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageChatModel() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MessageDataModel>? data)  $default,) {final _that = this;
switch (_that) {
case _MessageChatModel():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MessageDataModel>? data)?  $default,) {final _that = this;
switch (_that) {
case _MessageChatModel() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageChatModel implements MessageChatModel {
   _MessageChatModel({final  List<MessageDataModel>? data}): _data = data;
  factory _MessageChatModel.fromJson(Map<String, dynamic> json) => _$MessageChatModelFromJson(json);

 final  List<MessageDataModel>? _data;
@override List<MessageDataModel>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MessageChatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageChatModelCopyWith<_MessageChatModel> get copyWith => __$MessageChatModelCopyWithImpl<_MessageChatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageChatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageChatModel&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'MessageChatModel(data: $data)';
}


}

/// @nodoc
abstract mixin class _$MessageChatModelCopyWith<$Res> implements $MessageChatModelCopyWith<$Res> {
  factory _$MessageChatModelCopyWith(_MessageChatModel value, $Res Function(_MessageChatModel) _then) = __$MessageChatModelCopyWithImpl;
@override @useResult
$Res call({
 List<MessageDataModel>? data
});




}
/// @nodoc
class __$MessageChatModelCopyWithImpl<$Res>
    implements _$MessageChatModelCopyWith<$Res> {
  __$MessageChatModelCopyWithImpl(this._self, this._then);

  final _MessageChatModel _self;
  final $Res Function(_MessageChatModel) _then;

/// Create a copy of MessageChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(_MessageChatModel(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MessageDataModel>?,
  ));
}


}

// dart format on
