part of '../pages/home_page.dart';

typedef OnPageChangedCallback = void Function(DateTime date);
typedef OnDayTapCallback = void Function(DateTime date);

class _Calendar extends StatelessWidget {
  const _Calendar({
    required this.focusedDay,
    required this.onPageChanged,
    required this.onDayTapCallback,
  });

  final DateTime focusedDay;

  final OnPageChangedCallback onPageChanged;
  final OnDayTapCallback onDayTapCallback;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().date;
    final firstDay = DateTime(now.year, now.month - 1);
    final lastDay = DateTime(now.year, now.month + 2, 0);
    return TableCalendar(
      headerVisible: false,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.week,
      onPageChanged: onPageChanged,
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      daysOfWeekVisible: false,
      calendarStyle: const CalendarStyle(tablePadding: EdgeInsets.symmetric(horizontal: 10)),
      rowHeight: 68,
      calendarBuilders: CalendarBuilders<Widget>(
        prioritizedBuilder: (context, date, _) {
          final isFocused = isSameDay(date, focusedDay);
          final color = isFocused ? context.colorScheme.secondary : context.colorScheme.primary;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onDayTapCallback(date),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isFocused ? context.colorScheme.primary : Colors.transparent,
                border: isFocused ? null : Border.all(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: context.titleSmall?.copyWith(color: color),
                  ).alignAtBottomCenter().expanded(),
                  const Gap(2),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    onlyDayFormat.format(date),
                    style: context.bodySmall?.copyWith(color: color),
                  ).alignAtTopCenter().expanded(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
