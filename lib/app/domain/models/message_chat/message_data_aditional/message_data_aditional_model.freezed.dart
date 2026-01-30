// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_data_aditional_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageDataAditionalModel {

 DateTime? get updatedAt; DateTime? get createdAt; bool? get estado; String? get tipo; int? get totalEnviados; int? get totalRecibidos; int? get totalNoVistos; int? get totalNoVistosCliente; String? get chatId; DateTime? get lastMessageAt; String? get lastOperator; String? get id;
/// Create a copy of MessageDataAditionalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageDataAditionalModelCopyWith<MessageDataAditionalModel> get copyWith => _$MessageDataAditionalModelCopyWithImpl<MessageDataAditionalModel>(this as MessageDataAditionalModel, _$identity);

  /// Serializes this MessageDataAditionalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageDataAditionalModel&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.totalEnviados, totalEnviados) || other.totalEnviados == totalEnviados)&&(identical(other.totalRecibidos, totalRecibidos) || other.totalRecibidos == totalRecibidos)&&(identical(other.totalNoVistos, totalNoVistos) || other.totalNoVistos == totalNoVistos)&&(identical(other.totalNoVistosCliente, totalNoVistosCliente) || other.totalNoVistosCliente == totalNoVistosCliente)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.lastOperator, lastOperator) || other.lastOperator == lastOperator)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedAt,createdAt,estado,tipo,totalEnviados,totalRecibidos,totalNoVistos,totalNoVistosCliente,chatId,lastMessageAt,lastOperator,id);

@override
String toString() {
  return 'MessageDataAditionalModel(updatedAt: $updatedAt, createdAt: $createdAt, estado: $estado, tipo: $tipo, totalEnviados: $totalEnviados, totalRecibidos: $totalRecibidos, totalNoVistos: $totalNoVistos, totalNoVistosCliente: $totalNoVistosCliente, chatId: $chatId, lastMessageAt: $lastMessageAt, lastOperator: $lastOperator, id: $id)';
}


}

/// @nodoc
abstract mixin class $MessageDataAditionalModelCopyWith<$Res>  {
  factory $MessageDataAditionalModelCopyWith(MessageDataAditionalModel value, $Res Function(MessageDataAditionalModel) _then) = _$MessageDataAditionalModelCopyWithImpl;
@useResult
$Res call({
 DateTime? updatedAt, DateTime? createdAt, bool? estado, String? tipo, int? totalEnviados, int? totalRecibidos, int? totalNoVistos, int? totalNoVistosCliente, String? chatId, DateTime? lastMessageAt, String? lastOperator, String? id
});




}
/// @nodoc
class _$MessageDataAditionalModelCopyWithImpl<$Res>
    implements $MessageDataAditionalModelCopyWith<$Res> {
  _$MessageDataAditionalModelCopyWithImpl(this._self, this._then);

  final MessageDataAditionalModel _self;
  final $Res Function(MessageDataAditionalModel) _then;

/// Create a copy of MessageDataAditionalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updatedAt = freezed,Object? createdAt = freezed,Object? estado = freezed,Object? tipo = freezed,Object? totalEnviados = freezed,Object? totalRecibidos = freezed,Object? totalNoVistos = freezed,Object? totalNoVistosCliente = freezed,Object? chatId = freezed,Object? lastMessageAt = freezed,Object? lastOperator = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,estado: freezed == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as bool?,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String?,totalEnviados: freezed == totalEnviados ? _self.totalEnviados : totalEnviados // ignore: cast_nullable_to_non_nullable
as int?,totalRecibidos: freezed == totalRecibidos ? _self.totalRecibidos : totalRecibidos // ignore: cast_nullable_to_non_nullable
as int?,totalNoVistos: freezed == totalNoVistos ? _self.totalNoVistos : totalNoVistos // ignore: cast_nullable_to_non_nullable
as int?,totalNoVistosCliente: freezed == totalNoVistosCliente ? _self.totalNoVistosCliente : totalNoVistosCliente // ignore: cast_nullable_to_non_nullable
as int?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastOperator: freezed == lastOperator ? _self.lastOperator : lastOperator // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageDataAditionalModel].
extension MessageDataAditionalModelPatterns on MessageDataAditionalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageDataAditionalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageDataAditionalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageDataAditionalModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageDataAditionalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageDataAditionalModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageDataAditionalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? updatedAt,  DateTime? createdAt,  bool? estado,  String? tipo,  int? totalEnviados,  int? totalRecibidos,  int? totalNoVistos,  int? totalNoVistosCliente,  String? chatId,  DateTime? lastMessageAt,  String? lastOperator,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageDataAditionalModel() when $default != null:
return $default(_that.updatedAt,_that.createdAt,_that.estado,_that.tipo,_that.totalEnviados,_that.totalRecibidos,_that.totalNoVistos,_that.totalNoVistosCliente,_that.chatId,_that.lastMessageAt,_that.lastOperator,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? updatedAt,  DateTime? createdAt,  bool? estado,  String? tipo,  int? totalEnviados,  int? totalRecibidos,  int? totalNoVistos,  int? totalNoVistosCliente,  String? chatId,  DateTime? lastMessageAt,  String? lastOperator,  String? id)  $default,) {final _that = this;
switch (_that) {
case _MessageDataAditionalModel():
return $default(_that.updatedAt,_that.createdAt,_that.estado,_that.tipo,_that.totalEnviados,_that.totalRecibidos,_that.totalNoVistos,_that.totalNoVistosCliente,_that.chatId,_that.lastMessageAt,_that.lastOperator,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? updatedAt,  DateTime? createdAt,  bool? estado,  String? tipo,  int? totalEnviados,  int? totalRecibidos,  int? totalNoVistos,  int? totalNoVistosCliente,  String? chatId,  DateTime? lastMessageAt,  String? lastOperator,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _MessageDataAditionalModel() when $default != null:
return $default(_that.updatedAt,_that.createdAt,_that.estado,_that.tipo,_that.totalEnviados,_that.totalRecibidos,_that.totalNoVistos,_that.totalNoVistosCliente,_that.chatId,_that.lastMessageAt,_that.lastOperator,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageDataAditionalModel implements MessageDataAditionalModel {
   _MessageDataAditionalModel({this.updatedAt, this.createdAt, this.estado, this.tipo, this.totalEnviados, this.totalRecibidos, this.totalNoVistos, this.totalNoVistosCliente, this.chatId, this.lastMessageAt, this.lastOperator, this.id});
  factory _MessageDataAditionalModel.fromJson(Map<String, dynamic> json) => _$MessageDataAditionalModelFromJson(json);

@override final  DateTime? updatedAt;
@override final  DateTime? createdAt;
@override final  bool? estado;
@override final  String? tipo;
@override final  int? totalEnviados;
@override final  int? totalRecibidos;
@override final  int? totalNoVistos;
@override final  int? totalNoVistosCliente;
@override final  String? chatId;
@override final  DateTime? lastMessageAt;
@override final  String? lastOperator;
@override final  String? id;

/// Create a copy of MessageDataAditionalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageDataAditionalModelCopyWith<_MessageDataAditionalModel> get copyWith => __$MessageDataAditionalModelCopyWithImpl<_MessageDataAditionalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageDataAditionalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageDataAditionalModel&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.totalEnviados, totalEnviados) || other.totalEnviados == totalEnviados)&&(identical(other.totalRecibidos, totalRecibidos) || other.totalRecibidos == totalRecibidos)&&(identical(other.totalNoVistos, totalNoVistos) || other.totalNoVistos == totalNoVistos)&&(identical(other.totalNoVistosCliente, totalNoVistosCliente) || other.totalNoVistosCliente == totalNoVistosCliente)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.lastOperator, lastOperator) || other.lastOperator == lastOperator)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedAt,createdAt,estado,tipo,totalEnviados,totalRecibidos,totalNoVistos,totalNoVistosCliente,chatId,lastMessageAt,lastOperator,id);

@override
String toString() {
  return 'MessageDataAditionalModel(updatedAt: $updatedAt, createdAt: $createdAt, estado: $estado, tipo: $tipo, totalEnviados: $totalEnviados, totalRecibidos: $totalRecibidos, totalNoVistos: $totalNoVistos, totalNoVistosCliente: $totalNoVistosCliente, chatId: $chatId, lastMessageAt: $lastMessageAt, lastOperator: $lastOperator, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MessageDataAditionalModelCopyWith<$Res> implements $MessageDataAditionalModelCopyWith<$Res> {
  factory _$MessageDataAditionalModelCopyWith(_MessageDataAditionalModel value, $Res Function(_MessageDataAditionalModel) _then) = __$MessageDataAditionalModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime? updatedAt, DateTime? createdAt, bool? estado, String? tipo, int? totalEnviados, int? totalRecibidos, int? totalNoVistos, int? totalNoVistosCliente, String? chatId, DateTime? lastMessageAt, String? lastOperator, String? id
});




}
/// @nodoc
class __$MessageDataAditionalModelCopyWithImpl<$Res>
    implements _$MessageDataAditionalModelCopyWith<$Res> {
  __$MessageDataAditionalModelCopyWithImpl(this._self, this._then);

  final _MessageDataAditionalModel _self;
  final $Res Function(_MessageDataAditionalModel) _then;

/// Create a copy of MessageDataAditionalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updatedAt = freezed,Object? createdAt = freezed,Object? estado = freezed,Object? tipo = freezed,Object? totalEnviados = freezed,Object? totalRecibidos = freezed,Object? totalNoVistos = freezed,Object? totalNoVistosCliente = freezed,Object? chatId = freezed,Object? lastMessageAt = freezed,Object? lastOperator = freezed,Object? id = freezed,}) {
  return _then(_MessageDataAditionalModel(
updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,estado: freezed == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as bool?,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String?,totalEnviados: freezed == totalEnviados ? _self.totalEnviados : totalEnviados // ignore: cast_nullable_to_non_nullable
as int?,totalRecibidos: freezed == totalRecibidos ? _self.totalRecibidos : totalRecibidos // ignore: cast_nullable_to_non_nullable
as int?,totalNoVistos: freezed == totalNoVistos ? _self.totalNoVistos : totalNoVistos // ignore: cast_nullable_to_non_nullable
as int?,totalNoVistosCliente: freezed == totalNoVistosCliente ? _self.totalNoVistosCliente : totalNoVistosCliente // ignore: cast_nullable_to_non_nullable
as int?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastOperator: freezed == lastOperator ? _self.lastOperator : lastOperator // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
