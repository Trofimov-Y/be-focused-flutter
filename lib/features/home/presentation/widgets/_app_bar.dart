part of '../pages/home_page.dart';

class _AppBar extends StatefulWidget {
  const _AppBar({
    required this.onSettingsPressed,
    required this.onArchivePressed,
    required this.focussedDay,
    required this.onDateChanged,
  });

  final DateTime focussedDay;

  final VoidCallback onSettingsPressed;
  final VoidCallback onArchivePressed;

  final OnDayTapCallback onDateChanged;

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  late final _pageDateNotifier = ValueNotifier<DateTime>(widget.focussedDay.date);

  @override
  Widget build(BuildContext context) {
    return SliverAppBarWithBlur(
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      scrolledUnderElevation: 0,
      backgroundColor: context.colorScheme.onPrimary,
      pinned: true,
      actions: [
        IconButton(onPressed: widget.onArchivePressed, icon: const Icon(Clarity.archive_line)),
        IconButton(onPressed: widget.onSettingsPressed, icon: const Icon(Clarity.settings_line)),
      ],
      title: ValueListenableBuilder(
        valueListenable: _pageDateNotifier,
        builder: (context, date, child) {
          return Text(
            onlyMonthFormat.format(date),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ).animate(key: ValueKey(date.month)).fadeIn();
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: context.colorScheme.onSecondary)),
          ),
          padding: const EdgeInsets.only(bottom: 12),
          child: _Calendar(
            focusedDay: widget.focussedDay,
            onPageChanged: (date) => _pageDateNotifier.value = date,
            onDayTapCallback: widget.onDateChanged,
          ),
        ),
      ),
    );
  }
}
