import 'dart:math' as math;

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/extensions/context_extensions.dart';
import 'package:be_focused/app/utils/date_formatters.dart';
import 'package:be_focused/app/widgets/painters/circular_progress_painter.dart';
import 'package:be_focused/l10n/l10n.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

part '_archive_progress_painter.dart';

part '_timer.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    required this.title,
    required this.backgroundColor,
    required this.onTap,
    required this.onArchive,
    this.circularBorderRadius = 32,
    this.description,
    this.dateTimeRange,
    super.key,
  });

  final String title;
  final String? description;
  final DateTimeRange? dateTimeRange;

  final double circularBorderRadius;
  final Color backgroundColor;

  final VoidCallback onTap;

  /// Called when the archive animation is completed
  final VoidCallback onArchive;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> with SingleTickerProviderStateMixin {
  final _animationArchiveThreshold = 0.8;

  /// Used to get the height of the card for draw line between start and end time
  final _cardHeightKey = GlobalKey();

  var _cardHeight = 0.0;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );
  late final _archiveProgressTween = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.6, curve: Curves.ease),
    ),
  );

  late final _opacityTween = Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.55, 0.8, curve: Curves.ease),
    ),
  );

  late final _sizeTween = Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(_animationArchiveThreshold, 1, curve: Curves.ease),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _cardHeightKey.currentContext?.findRenderObject() as RenderBox?;
      setState(() {
        _cardHeight = box?.size.height ?? 0;
      });
    });

    _animationController.addListener(() {
      if (_animationController.value > _animationArchiveThreshold) {
        widget.onArchive();
      }
    });
  }

  @override
  void dispose() {
    _cardHeightKey.currentState?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeRange = widget.dateTimeRange;
    final description = widget.description;

    return GestureDetector(
      onTap: () {
        widget.onTap();
        HapticFeedback.mediumImpact();
      },
      onLongPressStart: (_) {
        _animationController.forward();
        HapticFeedback.lightImpact();
      },
      onLongPressUp: () {
        if (_archiveProgressTween.value < _animationArchiveThreshold) {
          _animationController.reverse();
        }
      },
      child: FadeTransition(
        opacity: _opacityTween,
        child: SizeTransition(
          sizeFactor: _sizeTween,
          child: AnimatedBuilder(
            animation: _archiveProgressTween,
            builder: (context, child) {
              return CustomPaint(
                foregroundPainter: ArchiveProgressPainter(
                  progress: _archiveProgressTween.value,
                  color: context.colorScheme.primary,
                  borderRadius: widget.circularBorderRadius,
                ),
                child: child,
              );
            },
            child: Container(
              key: _cardHeightKey,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              constraints: const BoxConstraints(minHeight: 96),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.circularBorderRadius),
              ),
              child: Row(
                children: [
                  if (timeRange != null) ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          timeFormat.format(timeRange.start),
                          style: context.titleMedium?.bold.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: context.colorScheme.secondary,
                          ),
                          maxLines: 1,
                        ),
                        const Gap(2),
                        AnimatedContainer(
                          width: 2,
                          color: context.colorScheme.secondary,
                          height: _cardHeight * 0.15,
                          duration: const Duration(milliseconds: 700),
                        ),
                        Text(
                          timeFormat.format(timeRange.end),
                          style: context.titleMedium?.bold.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: context.colorScheme.secondary,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const Gap(16),
                  ],
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: context.titleMedium?.bold.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: context.colorScheme.secondary,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                      Visibility(
                        visible: description != null,
                        child: Text(
                          description.orEmpty(),
                          style: context.titleSmall?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: context.colorScheme.secondary,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ).expanded(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
