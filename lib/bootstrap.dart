import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gw_sms/app/data/http/http.dart';
import 'package:gw_sms/app/data/repositories_impl/ms_sms_repository_impl.dart';
import 'package:gw_sms/app/data/services/remote/ms_sms_api.dart';
import 'package:gw_sms/app/data/services/socket/web_socket_service.dart';
import 'package:gw_sms/app/data/services/utils/local_providers.dart';
import 'package:gw_sms/app/domain/repositories/ms_sms_repository.dart';
import 'package:gw_sms/app/presentation/global/controllers/theme_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

http.Client createHttpClientWithSelfSigned() {
  final ioClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        true;
  return IOClient(ioClient);
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  final httpServices = Http(
    baseUrl: 'http://172.27.38.56:3515',
    //baseUrl: 'https://r05290mh-3515.brs.devtunnels.ms',
    userAgent: 'userAgent',
    ip: 'ipServer',
    // baseUrl: "https://mpv2-gw.stage.mp.gob.bo",
    // baseUrl: "https://mpv2-gw.dev.mp.gob.bo",
    // baseUrl: "http://172.27.38.60:8110",
    //client: http.Client(),
    client: createHttpClientWithSelfSigned(),
  );

  // Add cross-flavor configuration here
  const secureStorage = FlutterSecureStorage();
  final darkModeEnabled = await secureStorage.read(key: 'dark_mode') == 'true';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(darkModeEnabled),
        ),
        ChangeNotifierProvider(create: (_) => WebSocketService2()),
        ChangeNotifierProvider(create: (_) => BottomBarStateOptionsActividad()),
        Provider<MsSmsRepository>(
          create: (_) => MsSmsRepositoryImpl(
            MsSmsAPI(httpServices),
          ),
        ),
      ],
      child: await builder(),
    ),
  );
}
