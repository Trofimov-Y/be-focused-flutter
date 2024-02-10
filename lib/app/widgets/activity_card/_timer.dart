part of 'activity_card.dart';

// TODO(Yuriy-Trofimov): implement this feature later
// ignore: unused_element
class _Timer extends StatelessWidget {
  const _Timer({
    required this.isActive,
    required this.leftTime,
    required this.totalDuration,
    required this.onTap,
  });

  final bool isActive;
  final VoidCallback? onTap;

  final Duration leftTime;
  final Duration totalDuration;

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (leftTime.inSeconds / totalDuration.inSeconds);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          foregroundPainter: CircularProgressPainter(progress: progress),
          child: InkWell(
            onTap: () {
              onTap?.call();
              HapticFeedback.lightImpact();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Icon(
                isActive ? Icons.pause : Icons.play_arrow,
                color: context.colors.primary,
              ),
            ),
          ),
        ),
        const Gap(4),
        Text(
          context.l10n.minutes(leftTime.inMinutes),
          style: context.titleSmall?.bold.copyWith(
            overflow: TextOverflow.ellipsis,
            color: context.colors.secondary,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
