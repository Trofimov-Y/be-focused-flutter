import 'package:auto_route/auto_route.dart';
import 'package:be_focused/app/routing/transitions/native_android_transition.dart';
import 'package:be_focused/features/authentication/pages/authentication_page.dart';
import 'package:be_focused/features/home/pages/home_page.dart';
import 'package:be_focused/features/settings/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter(this._auth);

  final FirebaseAuth _auth;

  @override
  RouterConfig<UrlState> config({
    List<PageRouteInfo>? initialRoutes,
    String? initialDeepLink,
    DeepLinkBuilder? deepLinkBuilder,
    String? navRestorationScopeId,
    WidgetBuilder? placeholder,
    NavigatorObserversBuilder navigatorObservers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
    bool includePrefixMatches = !kIsWeb,
    bool Function(String? location)? neglectWhen,
    bool rebuildStackOnDeepLink = false,
    Listenable? reevaluateListenable,
  }) {
    return super.config(
      reevaluateListenable: ReevaluateListenable.stream(_auth.authStateChanges()),
      navigatorObservers: () => [...navigatorObservers(), AutoRouterObserver()],
    );
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _auth.currentUser != null;
    if (isAuthenticated || resolver.route.name == AuthenticationRoute.name) {
      resolver.next();
    } else {
      resolver.redirect(const AuthenticationRoute());
    }
  }

  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      transitionsBuilder: (context, primaryAnimation, secondaryAnimation, child) {
        return NativeAndroidTransition(
          primaryRouteAnimation: primaryAnimation,
          secondaryRouteAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: AuthenticationRoute.page),
      AutoRoute(page: HomeRoute.page, initial: true),
      AutoRoute(page: SettingsRoute.page),
    ];
  }
}
