part of '../pages/home_page.dart';

typedef OnPageChangedCallback = void Function(DateTime date);
typedef OnDayTapCallback = void Function(DateTime date);

class _Calendar extends StatelessWidget {
  const _Calendar({
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.onPageChanged,
    required this.onDayTapCallback,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;

  final OnPageChangedCallback onPageChanged;
  final OnDayTapCallback onDayTapCallback;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerVisible: false,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onPageChanged: onPageChanged,
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      daysOfWeekVisible: false,
      calendarStyle: const CalendarStyle(tablePadding: EdgeInsets.symmetric(horizontal: 10)),
      rowHeight: 68,
      calendarBuilders: CalendarBuilders<Widget>(
        prioritizedBuilder: (context, date, _) {
          final isFocused = isSameDay(date, focusedDay);
          final color = isFocused ? context.colors.secondary : context.colors.primary;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onDayTapCallback(date),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isFocused ? context.colors.primary : Colors.transparent,
                border: isFocused ? null : Border.all(color: context.colors.primary),
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
                      color: context.colors.onSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    date.onlyDayFormat,
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
