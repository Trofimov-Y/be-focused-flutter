part of '../pages/home_page.dart';

typedef OnSaveActivityCallBack = void Function(
  String title,
  String? description,
  int color,
  DateTime startedAt,
  Duration? duration,
);

class CreateActivityBottomSheet extends StatefulWidget {
  const CreateActivityBottomSheet({
    required this.onSave,
    required this.focusedDate,
    required this.maximumDate,
    super.key,
  });

  final DateTime focusedDate;
  final DateTime maximumDate;
  final OnSaveActivityCallBack onSave;

  @override
  State<CreateActivityBottomSheet> createState() => _CreateActivityBottomSheetState();
}

class _CreateActivityBottomSheetState extends State<CreateActivityBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  bool _showDescriptionFiled = false;
  bool _showColorPalette = false;

  int colorValue = ActivityColors.random.value;

  DateTime? _dateTime;
  DateTimeRange? _timeRange;

  @override
  Widget build(BuildContext context) {
    final timeRange = _timeRange;
    final dateTime = _dateTime;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: context.colors.secondary,
        border: Border(
          top: BorderSide(color: context.colors.primary),
        ),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 6,
        right: 6,
        bottom: max(context.mediaQueryViewInsets.bottom, context.mediaQueryViewPadding.bottom) + 4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Enter a title'),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              textInputAction: _showDescriptionFiled ? TextInputAction.next : TextInputAction.done,
              style: TextStyle(color: context.colors.primary),
            ),
          ),
          if (_showDescriptionFiled) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                focusNode: _descriptionFocusNode,
                decoration: const InputDecoration(hintText: 'Enter a description'),
                style: TextStyle(color: context.colors.primary),
                textInputAction: TextInputAction.done,
                maxLines: 3,
                minLines: 1,
              ),
            ),
          ],
          const Gap(4),
          if (dateTime != null) ...[
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _dateTime = null;
                      _timeRange = null;
                    });
                  },
                  icon: const Icon(Clarity.times_line),
                ),
                Text(
                  dateTime.weekdayDateFormat,
                  style: context.textTheme.titleMedium?.copyWith(color: context.colors.primary),
                ).expanded(),
                if (timeRange != null) ...[
                  Text(
                    '${timeRange.start.timeFormat} - ${timeRange.end.timeFormat}',
                    style: context.textTheme.titleMedium?.copyWith(color: context.colors.primary),
                  ),
                ],
                const Gap(10),
              ],
            ),
          ],
          if (_showColorPalette) ...[
            if (dateTime == null) const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...ActivityColors.colors.map((color) {
                  return Radio(
                    fillColor: MaterialStateProperty.all(color),
                    value: color.value,
                    groupValue: colorValue,
                    onChanged: (value) => setState(() => value?.let((it) => colorValue = it)),
                  );
                }),
              ],
            ).animate().fadeIn(),
          ],
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() => _showDescriptionFiled = true);
                  _descriptionFocusNode.requestFocus();
                },
                icon: const Icon(Clarity.details_line),
              ),
              IconButton(
                onPressed: () {
                  setState(() => _showColorPalette = !_showColorPalette);
                },
                icon: const Icon(Clarity.color_palette_solid),
              ),
              IconButton(
                onPressed: () {
                  showDatePicker(context, widget.focusedDate, widget.maximumDate).then(
                    (value) {
                      if (context.mounted) {
                        setState(() {
                          _dateTime = value;
                          _timeRange = null;
                        });
                      }
                    },
                  );
                },
                icon: const Icon(Clarity.calendar_line),
              ),
              if (dateTime != null) ...[
                IconButton(
                  onPressed: () {
                    showTimeRangePicker(context, dateTime.date, timeRange).then((value) {
                      if (context.mounted) {
                        setState(() {
                          _dateTime = value.start;
                          _timeRange = value;
                        });
                      }
                    });
                  },
                  icon: const Icon(Clarity.clock_line),
                ),
              ],
              const Spacer(),
              if (_titleController.text.trim().isNotEmpty) ...[
                TextButton(
                  onPressed: () {
                    final title = _titleController.text.trim();
                    final description = _descriptionController.text.trim();
                    final startedAt = (_timeRange?.start ?? _dateTime) ?? DateTime.now();
                    final duration = _timeRange?.let((it) => it.end.difference(it.start));

                    widget.onSave(
                      title,
                      description.isNotEmpty ? description : null,
                      colorValue,
                      startedAt,
                      duration,
                    );
                  },
                  child: Text(
                    'Save',
                    style: context.textTheme.titleMedium?.copyWith(color: context.colors.primary),
                  ),
                ).animate().fadeIn(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

Future<DateTime?> showDatePicker(
  BuildContext context,
  DateTime focusedDate,
  DateTime maxDate,
) async {
  var pickedDateTime = focusedDate;

  await showModalBottomSheet<void>(
    elevation: 0,
    constraints: const BoxConstraints(maxHeight: 360),
    backgroundColor: context.colors.secondary,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(top: BorderSide(color: context.colors.primary)),
        ),
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: context.textTheme.titleLarge?.copyWith(
                color: context.colors.primary,
              ),
            ),
          ),
          child: CupertinoDatePicker(
            showDayOfWeek: true,
            initialDateTime: focusedDate,
            minimumYear: focusedDate.year,
            maximumYear: maxDate.year,
            maximumDate: maxDate,
            use24hFormat: true,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime dateTime) {
              pickedDateTime = dateTime;
              HapticFeedback.lightImpact();
            },
          ),
        ),
      );
    },
  );
  if (pickedDateTime < focusedDate.date) {
    return focusedDate.date;
  }
  return pickedDateTime;
}

Future<DateTimeRange> showTimeRangePicker(
  BuildContext context,
  DateTime date,
  DateTimeRange? range, {
  Duration durationStep = const Duration(minutes: 1),
}) async {
  final pickedRange = ValueNotifier<DateTimeRange>(
    range ?? DateTimeRange(start: date, end: date.add(durationStep)),
  );
  await showModalBottomSheet<void>(
    elevation: 0,
    constraints: const BoxConstraints(maxHeight: 360),
    backgroundColor: context.colors.secondary,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(top: BorderSide(color: context.colors.primary)),
        ),
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: context.textTheme.titleLarge?.copyWith(
                color: context.colors.primary,
              ),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: pickedRange,
            builder: (context, value, _) {
              return Row(
                children: [
                  CupertinoDatePicker(
                    minimumDate: date,
                    initialDateTime: date.add(durationStep),
                    maximumDate: DateTime(date.year, date.month, date.day + 1),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    minuteInterval: durationStep.inMinutes,
                    onDateTimeChanged: (DateTime date) {
                      final end = switch (date > pickedRange.value.end) {
                        true => date.add(durationStep),
                        false => pickedRange.value.end,
                      };
                      pickedRange.value = DateTimeRange(start: date, end: end);
                      HapticFeedback.lightImpact();
                    },
                  ).expanded(),
                  CupertinoDatePicker(
                    key: ValueKey(value.start),
                    minimumDate: value.start,
                    initialDateTime: value.end,
                    maximumDate: DateTime(date.year, date.month, date.day + 1),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime dateTime) {
                      pickedRange.value = DateTimeRange(start: value.start, end: dateTime);
                      HapticFeedback.lightImpact();
                    },
                  ).expanded(),
                ],
              );
            },
          ),
        ),
      );
    },
  );
  return pickedRange.value;
}
