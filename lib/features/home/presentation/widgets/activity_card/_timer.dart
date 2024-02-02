part of 'activity_card.dart';

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
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Icon(
                isActive ? Icons.pause : Icons.play_arrow,
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
        const Gap(4),
        // TODO(Yuriy-Trofimov): Add localization.
        Text(
          '${leftTime.inMinutes} min',
          style: context.titleSmall?.bold.copyWith(
            overflow: TextOverflow.ellipsis,
            color: context.colorScheme.secondary,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
