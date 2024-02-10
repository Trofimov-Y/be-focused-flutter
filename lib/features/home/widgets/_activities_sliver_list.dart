part of '../pages/home_page.dart';

class _ActivitiesSliverList extends StatelessWidget {
  const _ActivitiesSliverList({
    required this.activities,
    required this.stickyHeader,
    required this.onDoubleTap,
  });

  final String stickyHeader;

  final void Function(Activity activity) onDoubleTap;

  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return SliverVisibility(
      visible: activities.isNotEmpty,
      sliver: SliverStickyHeader.builder(
        builder: (context, state) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(color: context.colors.onBackground),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  stickyHeader,
                  style: context.titleMedium?.bold.copyWith(color: context.colors.primary),
                ),
              ),
            ),
          ).animate().fadeIn();
        },
        sliver: SliverList.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
              child: ActivityCard(
                backgroundColor: Color(activity.color),
                startedAt: activity.startedAt,
                duration: activity.duration,
                title: activity.title,
                description: activity.description,
                isCompleted: activity.completedAt != null,
                onDoubleTap: () => onDoubleTap(activity),
              ),
            );
          },
        ),
      ),
    );
  }
}
