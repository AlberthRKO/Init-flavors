import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gw_sms/app/data/services/socket/web_socket_service.dart';
import 'package:gw_sms/app/data/services/utils/local_providers.dart';
import 'package:gw_sms/app/presentation/global/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

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
      ],
      child: await builder(),
    ),
  );
}
