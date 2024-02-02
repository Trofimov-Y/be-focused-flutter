part of 'activity_card.dart';

class ArchiveProgressPainter extends CustomPainter {
  const ArchiveProgressPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
    this.strokeWidth = 5,
  });

  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeOffset = strokeWidth / 2;
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final cornerCircumference = 2 * math.pi * borderRadius;
    final totalLength = 2 * size.width + 2 * size.height - 8 * borderRadius + cornerCircumference;
    var progressLength = totalLength * progress;

    // Top edge
    final topEdgeLength = size.width / 2 - borderRadius;
    if (progressLength <= topEdgeLength) {
      canvas.drawLine(
        Offset(size.width / 2, strokeOffset),
        Offset(size.width / 2 + progressLength, strokeOffset),
        progressPaint,
      );
      return;
    }
    canvas.drawLine(
      Offset(size.width / 2, strokeOffset),
      Offset(size.width - borderRadius, strokeOffset),
      progressPaint,
    );
    progressLength -= topEdgeLength;

    // Top-right corner
    if (progressLength <= cornerCircumference / 4) {
      canvas.drawArc(
        Rect.fromLTWH(
          size.width - 2 * borderRadius,
          strokeOffset,
          2 * borderRadius - strokeOffset,
          2 * borderRadius - strokeOffset,
        ),
        -math.pi / 2,
        progressLength / borderRadius,
        false,
        progressPaint,
      );
      return;
    }
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - 2 * borderRadius,
        strokeOffset,
        2 * borderRadius - strokeOffset,
        2 * borderRadius - strokeOffset,
      ),
      -math.pi / 2,
      math.pi / 2,
      false,
      progressPaint,
    );
    progressLength -= cornerCircumference / 4;

    // Right edge
    if (progressLength <= size.height - 2 * borderRadius) {
      canvas.drawLine(
        Offset(size.width - strokeOffset, borderRadius),
        Offset(size.width - strokeOffset, borderRadius + progressLength),
        progressPaint,
      );
      return;
    }
    canvas.drawLine(
      Offset(size.width - strokeOffset, borderRadius),
      Offset(size.width - strokeOffset, size.height - borderRadius),
      progressPaint,
    );
    progressLength -= size.height - 2 * borderRadius;

    // Bottom-right corner
    if (progressLength <= cornerCircumference / 4) {
      canvas.drawArc(
        Rect.fromLTWH(
          size.width - 2 * borderRadius,
          size.height - 2 * borderRadius,
          2 * borderRadius - strokeOffset,
          2 * borderRadius - strokeOffset,
        ),
        0,
        progressLength / borderRadius,
        false,
        progressPaint,
      );
      return;
    }
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - 2 * borderRadius,
        size.height - 2 * borderRadius,
        2 * borderRadius - strokeOffset,
        2 * borderRadius - strokeOffset,
      ),
      0,
      math.pi / 2,
      false,
      progressPaint,
    );
    progressLength -= cornerCircumference / 4;

    // Bottom edge
    if (progressLength <= size.width - 2 * borderRadius) {
      canvas.drawLine(
        Offset(size.width - borderRadius, size.height - strokeOffset),
        Offset(size.width - borderRadius - progressLength, size.height - strokeOffset),
        progressPaint,
      );
      return;
    }
    canvas.drawLine(
      Offset(size.width - borderRadius, size.height - strokeOffset),
      Offset(borderRadius, size.height - strokeOffset),
      progressPaint,
    );
    progressLength -= size.width - 2 * borderRadius;

    // Bottom-left corner
    if (progressLength <= cornerCircumference / 4) {
      canvas.drawArc(
        Rect.fromLTWH(
          strokeOffset,
          size.height - 2 * borderRadius,
          2 * borderRadius - strokeOffset,
          2 * borderRadius - strokeOffset,
        ),
        math.pi / 2,
        progressLength / borderRadius,
        false,
        progressPaint,
      );
      return;
    }
    canvas.drawArc(
      Rect.fromLTWH(
        strokeOffset,
        size.height - 2 * borderRadius,
        2 * borderRadius - strokeOffset,
        2 * borderRadius - strokeOffset,
      ),
      math.pi / 2,
      math.pi / 2,
      false,
      progressPaint,
    );
    progressLength -= cornerCircumference / 4;

    // Left edge
    if (progressLength <= size.height - 2 * borderRadius) {
      canvas.drawLine(
        Offset(strokeOffset, size.height - borderRadius),
        Offset(strokeOffset, size.height - borderRadius - progressLength),
        progressPaint,
      );
      return;
    }
    canvas.drawLine(
      Offset(strokeOffset, size.height - borderRadius),
      Offset(strokeOffset, borderRadius),
      progressPaint,
    );
    progressLength -= size.height - 2 * borderRadius;

    // Top-left corner
    if (progressLength <= cornerCircumference / 4) {
      canvas.drawArc(
        Rect.fromLTWH(
          strokeOffset,
          strokeOffset,
          2 * borderRadius - strokeOffset,
          2 * borderRadius - strokeOffset,
        ),
        math.pi,
        progressLength / borderRadius,
        false,
        progressPaint,
      );
      return;
    }
    canvas.drawArc(
      Rect.fromLTWH(
        strokeOffset,
        strokeOffset,
        2 * borderRadius - strokeOffset,
        2 * borderRadius - strokeOffset,
      ),
      math.pi,
      math.pi / 2,
      false,
      progressPaint,
    );
    progressLength -= cornerCircumference / 4;

    // Top edge (remaining part)
    if (progressLength > 0) {
      canvas.drawLine(
        Offset(borderRadius, strokeOffset),
        Offset(borderRadius + progressLength, strokeOffset),
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
