// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageResponseModel {

 DateTime? get updatedAt; DateTime? get createdAt; String? get message; bool? get visto; bool? get multimedia; SenderModel? get sender; bool? get esCliente; String? get appChatId; MessageTypeModel? get messageType; MessageDataAditionalModel? get dataAdicional; String? get id; String? get thumbnailFile; String? get urlFile; dynamic get autoMessage;
/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageResponseModelCopyWith<MessageResponseModel> get copyWith => _$MessageResponseModelCopyWithImpl<MessageResponseModel>(this as MessageResponseModel, _$identity);

  /// Serializes this MessageResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageResponseModel&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.message, message) || other.message == message)&&(identical(other.visto, visto) || other.visto == visto)&&(identical(other.multimedia, multimedia) || other.multimedia == multimedia)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.esCliente, esCliente) || other.esCliente == esCliente)&&(identical(other.appChatId, appChatId) || other.appChatId == appChatId)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dataAdicional, dataAdicional) || other.dataAdicional == dataAdicional)&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbnailFile, thumbnailFile) || other.thumbnailFile == thumbnailFile)&&(identical(other.urlFile, urlFile) || other.urlFile == urlFile)&&const DeepCollectionEquality().equals(other.autoMessage, autoMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedAt,createdAt,message,visto,multimedia,sender,esCliente,appChatId,messageType,dataAdicional,id,thumbnailFile,urlFile,const DeepCollectionEquality().hash(autoMessage));

@override
String toString() {
  return 'MessageResponseModel(updatedAt: $updatedAt, createdAt: $createdAt, message: $message, visto: $visto, multimedia: $multimedia, sender: $sender, esCliente: $esCliente, appChatId: $appChatId, messageType: $messageType, dataAdicional: $dataAdicional, id: $id, thumbnailFile: $thumbnailFile, urlFile: $urlFile, autoMessage: $autoMessage)';
}


}

/// @nodoc
abstract mixin class $MessageResponseModelCopyWith<$Res>  {
  factory $MessageResponseModelCopyWith(MessageResponseModel value, $Res Function(MessageResponseModel) _then) = _$MessageResponseModelCopyWithImpl;
@useResult
$Res call({
 DateTime? updatedAt, DateTime? createdAt, String? message, bool? visto, bool? multimedia, SenderModel? sender, bool? esCliente, String? appChatId, MessageTypeModel? messageType, MessageDataAditionalModel? dataAdicional, String? id, String? thumbnailFile, String? urlFile, dynamic autoMessage
});


$SenderModelCopyWith<$Res>? get sender;$MessageTypeModelCopyWith<$Res>? get messageType;$MessageDataAditionalModelCopyWith<$Res>? get dataAdicional;

}
/// @nodoc
class _$MessageResponseModelCopyWithImpl<$Res>
    implements $MessageResponseModelCopyWith<$Res> {
  _$MessageResponseModelCopyWithImpl(this._self, this._then);

  final MessageResponseModel _self;
  final $Res Function(MessageResponseModel) _then;

/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updatedAt = freezed,Object? createdAt = freezed,Object? message = freezed,Object? visto = freezed,Object? multimedia = freezed,Object? sender = freezed,Object? esCliente = freezed,Object? appChatId = freezed,Object? messageType = freezed,Object? dataAdicional = freezed,Object? id = freezed,Object? thumbnailFile = freezed,Object? urlFile = freezed,Object? autoMessage = freezed,}) {
  return _then(_self.copyWith(
updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,visto: freezed == visto ? _self.visto : visto // ignore: cast_nullable_to_non_nullable
as bool?,multimedia: freezed == multimedia ? _self.multimedia : multimedia // ignore: cast_nullable_to_non_nullable
as bool?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as SenderModel?,esCliente: freezed == esCliente ? _self.esCliente : esCliente // ignore: cast_nullable_to_non_nullable
as bool?,appChatId: freezed == appChatId ? _self.appChatId : appChatId // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as MessageTypeModel?,dataAdicional: freezed == dataAdicional ? _self.dataAdicional : dataAdicional // ignore: cast_nullable_to_non_nullable
as MessageDataAditionalModel?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,thumbnailFile: freezed == thumbnailFile ? _self.thumbnailFile : thumbnailFile // ignore: cast_nullable_to_non_nullable
as String?,urlFile: freezed == urlFile ? _self.urlFile : urlFile // ignore: cast_nullable_to_non_nullable
as String?,autoMessage: freezed == autoMessage ? _self.autoMessage : autoMessage // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SenderModelCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $SenderModelCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageTypeModelCopyWith<$Res>? get messageType {
    if (_self.messageType == null) {
    return null;
  }

  return $MessageTypeModelCopyWith<$Res>(_self.messageType!, (value) {
    return _then(_self.copyWith(messageType: value));
  });
}/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageDataAditionalModelCopyWith<$Res>? get dataAdicional {
    if (_self.dataAdicional == null) {
    return null;
  }

  return $MessageDataAditionalModelCopyWith<$Res>(_self.dataAdicional!, (value) {
    return _then(_self.copyWith(dataAdicional: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessageResponseModel].
extension MessageResponseModelPatterns on MessageResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? updatedAt,  DateTime? createdAt,  String? message,  bool? visto,  bool? multimedia,  SenderModel? sender,  bool? esCliente,  String? appChatId,  MessageTypeModel? messageType,  MessageDataAditionalModel? dataAdicional,  String? id,  String? thumbnailFile,  String? urlFile,  dynamic autoMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageResponseModel() when $default != null:
return $default(_that.updatedAt,_that.createdAt,_that.message,_that.visto,_that.multimedia,_that.sender,_that.esCliente,_that.appChatId,_that.messageType,_that.dataAdicional,_that.id,_that.thumbnailFile,_that.urlFile,_that.autoMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? updatedAt,  DateTime? createdAt,  String? message,  bool? visto,  bool? multimedia,  SenderModel? sender,  bool? esCliente,  String? appChatId,  MessageTypeModel? messageType,  MessageDataAditionalModel? dataAdicional,  String? id,  String? thumbnailFile,  String? urlFile,  dynamic autoMessage)  $default,) {final _that = this;
switch (_that) {
case _MessageResponseModel():
return $default(_that.updatedAt,_that.createdAt,_that.message,_that.visto,_that.multimedia,_that.sender,_that.esCliente,_that.appChatId,_that.messageType,_that.dataAdicional,_that.id,_that.thumbnailFile,_that.urlFile,_that.autoMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? updatedAt,  DateTime? createdAt,  String? message,  bool? visto,  bool? multimedia,  SenderModel? sender,  bool? esCliente,  String? appChatId,  MessageTypeModel? messageType,  MessageDataAditionalModel? dataAdicional,  String? id,  String? thumbnailFile,  String? urlFile,  dynamic autoMessage)?  $default,) {final _that = this;
switch (_that) {
case _MessageResponseModel() when $default != null:
return $default(_that.updatedAt,_that.createdAt,_that.message,_that.visto,_that.multimedia,_that.sender,_that.esCliente,_that.appChatId,_that.messageType,_that.dataAdicional,_that.id,_that.thumbnailFile,_that.urlFile,_that.autoMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageResponseModel implements MessageResponseModel {
   _MessageResponseModel({this.updatedAt, this.createdAt, this.message, this.visto, this.multimedia, this.sender, this.esCliente, this.appChatId, this.messageType, this.dataAdicional, this.id, this.thumbnailFile, this.urlFile, this.autoMessage});
  factory _MessageResponseModel.fromJson(Map<String, dynamic> json) => _$MessageResponseModelFromJson(json);

@override final  DateTime? updatedAt;
@override final  DateTime? createdAt;
@override final  String? message;
@override final  bool? visto;
@override final  bool? multimedia;
@override final  SenderModel? sender;
@override final  bool? esCliente;
@override final  String? appChatId;
@override final  MessageTypeModel? messageType;
@override final  MessageDataAditionalModel? dataAdicional;
@override final  String? id;
@override final  String? thumbnailFile;
@override final  String? urlFile;
@override final  dynamic autoMessage;

/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageResponseModelCopyWith<_MessageResponseModel> get copyWith => __$MessageResponseModelCopyWithImpl<_MessageResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageResponseModel&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.message, message) || other.message == message)&&(identical(other.visto, visto) || other.visto == visto)&&(identical(other.multimedia, multimedia) || other.multimedia == multimedia)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.esCliente, esCliente) || other.esCliente == esCliente)&&(identical(other.appChatId, appChatId) || other.appChatId == appChatId)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dataAdicional, dataAdicional) || other.dataAdicional == dataAdicional)&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbnailFile, thumbnailFile) || other.thumbnailFile == thumbnailFile)&&(identical(other.urlFile, urlFile) || other.urlFile == urlFile)&&const DeepCollectionEquality().equals(other.autoMessage, autoMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedAt,createdAt,message,visto,multimedia,sender,esCliente,appChatId,messageType,dataAdicional,id,thumbnailFile,urlFile,const DeepCollectionEquality().hash(autoMessage));

@override
String toString() {
  return 'MessageResponseModel(updatedAt: $updatedAt, createdAt: $createdAt, message: $message, visto: $visto, multimedia: $multimedia, sender: $sender, esCliente: $esCliente, appChatId: $appChatId, messageType: $messageType, dataAdicional: $dataAdicional, id: $id, thumbnailFile: $thumbnailFile, urlFile: $urlFile, autoMessage: $autoMessage)';
}


}

/// @nodoc
abstract mixin class _$MessageResponseModelCopyWith<$Res> implements $MessageResponseModelCopyWith<$Res> {
  factory _$MessageResponseModelCopyWith(_MessageResponseModel value, $Res Function(_MessageResponseModel) _then) = __$MessageResponseModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime? updatedAt, DateTime? createdAt, String? message, bool? visto, bool? multimedia, SenderModel? sender, bool? esCliente, String? appChatId, MessageTypeModel? messageType, MessageDataAditionalModel? dataAdicional, String? id, String? thumbnailFile, String? urlFile, dynamic autoMessage
});


@override $SenderModelCopyWith<$Res>? get sender;@override $MessageTypeModelCopyWith<$Res>? get messageType;@override $MessageDataAditionalModelCopyWith<$Res>? get dataAdicional;

}
/// @nodoc
class __$MessageResponseModelCopyWithImpl<$Res>
    implements _$MessageResponseModelCopyWith<$Res> {
  __$MessageResponseModelCopyWithImpl(this._self, this._then);

  final _MessageResponseModel _self;
  final $Res Function(_MessageResponseModel) _then;

/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updatedAt = freezed,Object? createdAt = freezed,Object? message = freezed,Object? visto = freezed,Object? multimedia = freezed,Object? sender = freezed,Object? esCliente = freezed,Object? appChatId = freezed,Object? messageType = freezed,Object? dataAdicional = freezed,Object? id = freezed,Object? thumbnailFile = freezed,Object? urlFile = freezed,Object? autoMessage = freezed,}) {
  return _then(_MessageResponseModel(
updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,visto: freezed == visto ? _self.visto : visto // ignore: cast_nullable_to_non_nullable
as bool?,multimedia: freezed == multimedia ? _self.multimedia : multimedia // ignore: cast_nullable_to_non_nullable
as bool?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as SenderModel?,esCliente: freezed == esCliente ? _self.esCliente : esCliente // ignore: cast_nullable_to_non_nullable
as bool?,appChatId: freezed == appChatId ? _self.appChatId : appChatId // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as MessageTypeModel?,dataAdicional: freezed == dataAdicional ? _self.dataAdicional : dataAdicional // ignore: cast_nullable_to_non_nullable
as MessageDataAditionalModel?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,thumbnailFile: freezed == thumbnailFile ? _self.thumbnailFile : thumbnailFile // ignore: cast_nullable_to_non_nullable
as String?,urlFile: freezed == urlFile ? _self.urlFile : urlFile // ignore: cast_nullable_to_non_nullable
as String?,autoMessage: freezed == autoMessage ? _self.autoMessage : autoMessage // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SenderModelCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $SenderModelCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageTypeModelCopyWith<$Res>? get messageType {
    if (_self.messageType == null) {
    return null;
  }

  return $MessageTypeModelCopyWith<$Res>(_self.messageType!, (value) {
    return _then(_self.copyWith(messageType: value));
  });
}/// Create a copy of MessageResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageDataAditionalModelCopyWith<$Res>? get dataAdicional {
    if (_self.dataAdicional == null) {
    return null;
  }

  return $MessageDataAditionalModelCopyWith<$Res>(_self.dataAdicional!, (value) {
    return _then(_self.copyWith(dataAdicional: value));
  });
}
}

// dart format on
