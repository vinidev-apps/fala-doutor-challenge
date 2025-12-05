import 'package:fala_doutor_challenge/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();

    // Configuração dos métodos de suporte do Modular
    Modular.setNavigatorKey(
      navigatorKey,
    ); // Bom para controlar globalmente, fora do app, como em notificações push
    Modular.setObservers([
      // por exemplo, AnalyticsObserver
    ]);
    setPrintResolver(
      (text) => debugPrint("[MODULAR]: $text"),
    ); // Customização dos Logs

    return MaterialApp.router(
      title: 'Fala, doutor!',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: Modular.routerConfig,
    );
  }
}
