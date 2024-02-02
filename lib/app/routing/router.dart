import 'package:auto_route/auto_route.dart';
import 'package:be_focused/features/authentication/presentation/pages/authentication_page.dart';
import 'package:be_focused/features/home/presentation/pages/home_page.dart';
import 'package:be_focused/features/settings/presentation/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 1,
            end: 0,
          ).animate(CurvedAnimation(parent: secondaryAnimation, curve: Curves.fastOutSlowIn)),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-0.2, 0),
            ).animate(CurvedAnimation(parent: secondaryAnimation, curve: Curves.fastOutSlowIn)),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.2, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: HomeRoute.page),
      AutoRoute(page: AuthenticationRoute.page, initial: true),
      AutoRoute(page: SettingsRoute.page, fullscreenDialog: true),
    ];
  }
}
