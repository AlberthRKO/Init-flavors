import 'package:gw_sms/app/data/services/remote/ms_sms_api.dart';
import 'package:gw_sms/app/domain/either/either.dart';
import 'package:gw_sms/app/domain/models/error/error_model.dart';
import 'package:gw_sms/app/domain/models/message/message_model.dart';
import 'package:gw_sms/app/domain/repositories/ms_sms_repository.dart';

class MsSmsRepositoryImpl extends MsSmsRepository {
  MsSmsRepositoryImpl(this._msSmsAPI);
  final MsSmsAPI _msSmsAPI;

  @override
  Future<Either<ErrorModel, List<MessageModel>>> getMensajes(
    int page,
    int size,
    String? search,
  ) async {
    return _msSmsAPI.getMensajes(
      page: page,
      size: size,
      search: search,
    );
  }

  @override
  Future<Either<ErrorModel, void>> setChangeStateMsj(
    String messageId,
    String estado,
  ) async {
    return _msSmsAPI.setChangeStateMsj(
      messageId: messageId,
      estado: estado,
    );
  }
}
