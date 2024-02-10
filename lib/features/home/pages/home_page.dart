import 'dart:math';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/extensions/context_extensions.dart';
import 'package:be_focused/app/extensions/object_extensions.dart';
import 'package:be_focused/app/routing/router.dart';
import 'package:be_focused/app/theme/colors.dart';
import 'package:be_focused/app/utils/date_formatters.dart';
import 'package:be_focused/app/widgets/activity_card/activity_card.dart';
import 'package:be_focused/app/widgets/material/app_bar_with_blur.dart';
import 'package:be_focused/domain/entities/activity.dart';
import 'package:be_focused/features/home/bloc/home_cubit.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:table_calendar/table_calendar.dart';

part '../widgets/_calendar.dart';

part '../widgets/_app_bar.dart';

part '../widgets/_activities_sliver_list.dart';

part '../widgets/_create_activity_bottom_sheet.dart';

// TODO(Yuriy-Trofimov): Add localizations
@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => GetIt.instance.get<HomeCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final bloc = context.read<HomeCubit>();
          final now = DateTime.now();
          final statusWidget = _getStatusWidgetFromState(state, context);
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _AppBar(
                onDateChanged: bloc.changeDate,
                focusedDay: state.date,
                firstDay: now.firstDayOfYear,
                lastDay: now.lastDayOfYear,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.router.push(const SettingsRoute());
                    },
                    icon: const Icon(Clarity.settings_line),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        enableDrag: false,
                        isScrollControlled: true,
                        context: context,
                        elevation: 0,
                        builder: (context) {
                          return CreateActivityBottomSheet(
                            maximumDate: now.lastDayOfYear,
                            focusedDate: state.date,
                            onSave: (title, description, color, startedAt, duration) {
                              bloc.createActivity(
                                title: title,
                                description: description,
                                color: color,
                                startedAt: startedAt,
                                duration: duration,
                              );
                              context.router.pop();
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Clarity.add_line),
                  ),
                ],
              ),
              if (statusWidget != null) statusWidget,
              ...?state.mapOrNull(
                data: (state) {
                  return [
                    _ActivitiesSliverList(
                      activities: state.dailyActivities,
                      stickyHeader: 'Anytime',
                      onDoubleTap: bloc.completeActivity,
                    ),
                    _ActivitiesSliverList(
                      activities: state.plannedActivities,
                      stickyHeader: 'Planned',
                      onDoubleTap: bloc.completeActivity,
                    ),
                    _ActivitiesSliverList(
                      activities: state.completedActivities,
                      stickyHeader: 'Completed',
                      onDoubleTap: bloc.unCompleteActivity,
                    ),
                  ];
                },
              ),
              SliverGap(context.mediaQueryPadding.bottom),
            ],
          );
        },
      ),
    );
  }

  Widget? _getStatusWidgetFromState(HomeState state, BuildContext context) {
    return state.mapOrNull<Widget>(
      initial: (_) => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      ),
      data: (state) {
        if (state.activities.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                "You've had no activity today",
                style: context.textTheme.titleLarge?.copyWith(color: context.colors.primary),
              ),
            ),
          );
        }
        return null;
      },
      error: (_) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              'Error loading activities',
              style: context.textTheme.titleLarge?.copyWith(color: context.colors.primary),
            ),
          ),
        );
      },
    );
  }
}
