import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/extensions/context_extensions.dart';
import 'package:be_focused/app/routing/router.dart';
import 'package:be_focused/app/theme/colors.dart';
import 'package:be_focused/app/utils/date_formatters.dart';
import 'package:be_focused/app/widgets/activity_card/activity_card.dart';
import 'package:be_focused/app/widgets/material/app_bar_with_blur.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:table_calendar/table_calendar.dart';

part '../widgets/_calendar.dart';

part '../widgets/_app_bar.dart';

// TODO(Yuriy-Trofimov): Add localizations
@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: context.colorScheme.primary)),
        backgroundColor: context.colorScheme.background,
        onPressed: () {
          context.router.push(const SettingsRoute());
        },
        child: Icon(BoxIcons.bx_plus, color: context.colorScheme.primary),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _AppBar(
            onDateChanged: (DateTime date) {},
            focussedDay: DateTime(2024, 2, 2),
            onSettingsPressed: () {
              context.router.push(const SettingsRoute());
            },
            onArchivePressed: () {},
          ),
          SliverStickyHeader.builder(
            builder: (context, state) {
              return ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(color: context.colorScheme.onBackground),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Anytime',
                      style: context.titleMedium?.bold.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
            sliver: SliverList.list(
              children: [
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ActivityCard(
                    backgroundColor: const Color.fromRGBO(183, 223, 247, 1),
                    title: 'Morning exercise',
                    description:
                        '1. Push-ups - 10 times\n2. Squats - 20 times\n3. Pull-ups - 5 times',
                    onTap: () {},
                    onArchive: () {},
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ActivityCard(
                    backgroundColor: CardColors.emerald,
                    title: 'Make a homework',
                    description: 'Complete the homework for the next lesson',
                    onTap: () {},
                    onArchive: () {},
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ActivityCard(
                    backgroundColor: CardColors.yellow,
                    title: 'Buy a new light bulb',
                    onTap: () {},
                    onArchive: () {},
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ActivityCard(
                    backgroundColor: CardColors.strawberry,
                    title: 'Shopping at the Varus',
                    description: 'Do not forget to buy milk, bread and cheese',
                    onTap: () {},
                    onArchive: () {},
                  ),
                ),
                const Gap(8),
              ],
            ),
          ),
          const SliverGap(8),
          SliverStickyHeader.builder(
            builder: (context, state) {
              return ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(color: context.colorScheme.onPrimary),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Planed',
                      style: context.titleMedium?.bold.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
            sliver: SliverList.list(
              children: [
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ActivityCard(
                    backgroundColor: CardColors.pink,
                    dateTimeRange: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(const Duration(days: 1)),
                    ),
                    title: 'Meetings',
                    description: 'Meet with the team to discuss the new project',
                    onTap: () {},
                    onArchive: () {},
                  ),
                ),
                const Gap(8),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ActivityCard(
                      backgroundColor: CardColors.red,
                      dateTimeRange: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(const Duration(minutes: 30)),
                      ),
                      title: 'Gaming with friends',
                      description: 'DotA 2',
                      onTap: () {},
                      onArchive: () {},
                    ),
                  ),
                ),
                const Gap(8),
              ],
            ),
          ),
          SliverGap(60 + context.mediaQueryPadding.bottom),
        ],
      ),
    );
  }
}
