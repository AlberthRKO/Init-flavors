// ignore_for_file: avoid_dynamic_calls, document_ignores

import 'package:gw_sms/app/data/http/http.dart';
import 'package:gw_sms/app/domain/either/either.dart';
import 'package:gw_sms/app/domain/models/error/error_model.dart';
import 'package:gw_sms/app/domain/models/message/message_model.dart';
import 'package:gw_sms/app/domain/typedef.dart';

class MsSmsAPI {
  MsSmsAPI(
    this._http,
  );

  final Http _http;

  // cambiamos de user a void por el momento
  Future<Either<ErrorModel, List<MessageModel>>> getMensajes({
    required int page,
    required int size,
    String? search,
  }) async {
    final query = '?page=$page&size=$size';
    final result = await _http.request(
      '/v1/sms/messages$query',
      onSucces: (responseBody) {
        final list = List<Json>.from(responseBody['response']['data'] as List);
        return list
            .map(
              MessageModel.fromJson,
            )
            .toList();
      },
    );
    return result.when(
      left: Either.left,
      right: Either.right,
    );
  }

  // cambiamos de user a void por el momento
  Future<Either<ErrorModel, void>> setChangeStateMsj({
    required String messageId,
    required int status,
  }) async {
    final result = await _http.request(
      '/v1/sms/send-message/status',
      method: HttpMethod.post,
      body: {
        'messageId': messageId,
        'status': status,
      },
      onSucces: (responseBody) {},
    );
    return result.when(
      left: Either.left,
      right: (list) => const Either.right(null),
    );
  }

  /* Future<Either<ErrorModel, int>> getCountNoti({
    required String token,
    bool isJL = false,
  }) async {
    final result = await (isJL
        ? _httpJL.request(
            '/v2/ms-app-notificacion/mis-notificaciones/no-vistos/justicia-libre',
            method: HttpMethod.get,
            headers: {
              'Authorization': 'Bearer $token',
            },
            onSucces: (responseBody) {
              final json = responseBody as Map;
              return json['response']['data'] as int;
            },
          )
        : _http.request(
            '/v1/app-notificaciones/me/total-no-vistos',
            headers: {
              'Authorization': 'Bearer $token',
            },
            onSucces: (responseBody) {
              final json = responseBody as Map;
              return json['response'] as int;
            },
          ));

    return result.when(
      left: Either.left,
      right: Either.right,
    );
  } */
}
