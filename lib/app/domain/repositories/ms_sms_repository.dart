import 'package:gw_sms/app/domain/either/either.dart';
import 'package:gw_sms/app/domain/models/error/error_model.dart';
import 'package:gw_sms/app/domain/models/message/message_model.dart';

abstract class MsSmsRepository {
  Future<Either<ErrorModel, List<MessageModel>>> getMensajes(
    int page,
    int size,
    String? search,
  );
  Future<Either<ErrorModel, void>> setChangeStateMsj(
    String messageId,
    String estado,
  );
}
