part of '../pages/home_page.dart';

class _AppBar extends StatefulWidget {
  const _AppBar({
    required this.focusedDay,
    required this.lastDay,
    required this.firstDay,
    required this.onDateChanged,
    required this.actions,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;

  final List<Widget> actions;

  final OnDayTapCallback onDateChanged;

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  late final _pageDateNotifier = ValueNotifier<DateTime>(widget.focusedDay.date);

  @override
  Widget build(BuildContext context) {
    return SliverAppBarWithBlur(
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.onPrimary,
      pinned: true,
      actions: widget.actions,
      title: ValueListenableBuilder(
        valueListenable: _pageDateNotifier,
        builder: (context, date, child) {
          return Text(
            date.onlyMonthFormat,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ).animate(key: ValueKey(date.month)).fadeIn();
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: context.colors.onSecondary)),
          ),
          padding: const EdgeInsets.only(bottom: 12),
          child: _Calendar(
            focusedDay: widget.focusedDay,
            onPageChanged: (date) => _pageDateNotifier.value = date,
            onDayTapCallback: widget.onDateChanged,
            firstDay: widget.firstDay,
            lastDay: widget.lastDay,
          ),
        ),
      ),
    );
  }
}
