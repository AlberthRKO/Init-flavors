import 'package:gw_sms/app/app.dart';
import 'package:gw_sms/bootstrap.dart';
import 'package:gw_sms/core/clients_config/config.dart';

Future<void> main() async {
  Config.appFlavor = Flavor.staging;
  await bootstrap(() => const App());
}
