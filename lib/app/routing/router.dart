import 'package:auto_route/auto_route.dart';
import 'package:be_focused/counter/view/counter_page.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CounterRoute.page, initial: true),
      ];
}
