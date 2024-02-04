part of '../pages/authentication_page.dart';

class _SpinningCurvedText extends StatefulWidget {
  const _SpinningCurvedText({
    required this.text,
    required this.textStyle,
    required this.textRadius,
  });

  final String text;
  final TextStyle textStyle;
  final double textRadius;

  @override
  _SpinningCurvedTextState createState() => _SpinningCurvedTextState();
}

class _SpinningCurvedTextState extends State<_SpinningCurvedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return CustomPaint(
          painter: _CircularTextPainter(
            text: widget.text,
            textStyle: widget.textStyle,
            animationValue: _animationController.value,
            textRadius: widget.textRadius,
          ),
        );
      },
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  _CircularTextPainter({
    required this.text,
    required this.textStyle,
    required this.animationValue,
    required this.textRadius,
  });

  final String text;
  final TextStyle textStyle;
  final double textRadius;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(textDirection: ui.TextDirection.ltr);

    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    var totalAngle = 0.0;
    for (var i = 0; i < text.length; i++) {
      textPainter
        ..text = TextSpan(text: text[i], style: textStyle)
        ..layout();
      final charWidth = textPainter.width;
      final charAngle = (charWidth / (textRadius * math.pi * 2)) * math.pi * 2;

      // Positioning the character
      final angle = totalAngle + charAngle / 2 + math.pi * 2 * animationValue;
      final position = Offset(math.cos(angle), math.sin(angle)) * textRadius;
      canvas
        ..save()
        ..translate(position.dx, position.dy)
        ..rotate(angle + math.pi / 2); // Rotate the canvas for the character

      // Painting the character
      textPainter.paint(canvas, Offset(-charWidth / 2, -textPainter.height / 2));
      canvas.restore();

      // Increment the total angle by the angle for this character
      totalAngle += charAngle;
    }
  }

  @override
  bool shouldRepaint(_CircularTextPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
