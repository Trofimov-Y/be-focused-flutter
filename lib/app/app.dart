import 'package:be_focused/app/routing/router.dart';
import 'package:be_focused/app/theme/theme_data.dart';
import 'package:be_focused/l10n/l10n.dart';
import 'package:be_focused/observers/auto_router_observer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: GetIt.I.get<AppRouter>().config(navigatorObservers: () => [RoutingObserver()]),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
