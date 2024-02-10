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
    required this.isCompleted,
    required this.onDoubleTap,
    this.circularBorderRadius = 32,
    this.description,
    this.startedAt,
    this.duration,
    super.key,
  });

  final String title;
  final String? description;
  final bool isCompleted;

  final DateTime? startedAt;
  final Duration? duration;

  final double circularBorderRadius;
  final Color backgroundColor;

  final VoidCallback onDoubleTap;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> with SingleTickerProviderStateMixin {
  /// Used to get the height of the card for draw line between start and end time
  final _cardHeightKey = GlobalKey();

  var _cardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _cardHeightKey.currentContext?.findRenderObject() as RenderBox?;
      if (mounted) {
        setState(() {
          _cardHeight = box?.size.height ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _cardHeightKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.description;
    final startedAt = widget.startedAt;
    final duration = widget.duration;

    DateTimeRange? timeRange;

    if (startedAt != null && duration != null) {
      timeRange = DateTimeRange(
        start: startedAt,
        end: startedAt.add(duration),
      );
    }

    return GestureDetector(
      onDoubleTap: () {
        HapticFeedback.lightImpact();
        widget.onDoubleTap();
      },
      child: Opacity(
        opacity: widget.isCompleted ? 0.75 : 1,
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
                      timeRange.start.timeFormat,
                      style: context.titleMedium?.bold.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: context.colors.secondary,
                      ),
                      maxLines: 1,
                    ),
                    const Gap(2),
                    AnimatedContainer(
                      width: 2,
                      color: context.colors.secondary,
                      height: _cardHeight * 0.15,
                      duration: const Duration(milliseconds: 500),
                    ),
                    Text(
                      timeRange.end.timeFormat,
                      style: context.titleMedium?.bold.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: context.colors.secondary,
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
                      color: context.colors.secondary,
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
                        color: context.colors.secondary,
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
    );
  }
}
