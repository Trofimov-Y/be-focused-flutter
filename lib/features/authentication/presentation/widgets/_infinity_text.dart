part of '../pages/authentication_page.dart';

class _InfinityText extends StatefulWidget {
  const _InfinityText({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  State<_InfinityText> createState() => _InfinityTextState();
}

class _InfinityTextState extends State<_InfinityText> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    /// It's use for animate horizontal text scrolling
    /// Time and speed are good for most cases
    const scrollDuration = Duration(seconds: 3000);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        scrollDuration.inSeconds * 30,
        duration: scrollDuration,
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Text(
          widget.text.toUpperCase(),
          style: widget.style,
          textScaler: TextScaler.noScaling,
        );
      },
    );
  }
}
