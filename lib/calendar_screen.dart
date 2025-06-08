import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'homescreen.dart';

class CalendarScreen extends StatefulWidget {
  final List<ToDo> todoList;
  const CalendarScreen({super.key, required this.todoList});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<ToDo> getTasksForDay(DateTime day) {
    return widget.todoList
        .where(
          (todo) =>
              todo.date.year == day.year &&
              todo.date.month == day.month &&
              todo.date.day == day.day,
        )
        .toList();
  }

  List<int> getMarkedDays() {
    return widget.todoList
        .where(
          (todo) =>
              todo.date.year == _focusedDay.year &&
              todo.date.month == _focusedDay.month,
        )
        .map((todo) => todo.date.day)
        .toList();
  }

  Map<int, Color> getMarkedDayColors() {
    final map = <int, Color>{};
    for (final todo in widget.todoList) {
      if (todo.date.year == _focusedDay.year &&
          todo.date.month == _focusedDay.month) {
        map[todo.date.day] = todo.color;
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final markedDays = getMarkedDays();
    final markedDayColors = getMarkedDayColors();
    final daysInMonth = DateUtils.getDaysInMonth(
      _focusedDay.year,
      _focusedDay.month,
    );
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0: Sunday
    final weeks = <List<int?>>[];
    int day = 1 - firstWeekday;
    while (day <= daysInMonth) {
      final week = <int?>[];
      for (int i = 0; i < 7; i++) {
        if (day > 0 && day <= daysInMonth) {
          week.add(day);
        } else {
          week.add(null);
        }
        day++;
      }
      weeks.add(week);
    }
    final selectedTasks =
        _selectedDay != null ? getTasksForDay(_selectedDay!) : [];
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'CALENDER',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                        1,
                      );
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_focusedDay),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                        1,
                      );
                    });
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xF2EDE8F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('M', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('T', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('W', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('T', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('F', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ...weeks.map(
              (week) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    week.map((d) {
                      if (d == null) {
                        return const SizedBox(width: 32, height: 32);
                      }
                      final isMarked = markedDays.contains(d);
                      final isSelected =
                          _selectedDay != null &&
                          _selectedDay!.year == _focusedDay.year &&
                          _selectedDay!.month == _focusedDay.month &&
                          _selectedDay!.day == d;
                      return GestureDetector(
                        onTap:
                            isMarked
                                ? () {
                                  setState(() {
                                    _selectedDay = DateTime(
                                      _focusedDay.year,
                                      _focusedDay.month,
                                      d,
                                    );
                                  });
                                }
                                : null,
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration:
                              isMarked
                                  ? BoxDecoration(
                                    color: markedDayColors[d]!.withOpacity(
                                      isSelected ? 0.7 : 0.3,
                                    ),
                                    shape: BoxShape.circle,
                                    border:
                                        isSelected
                                            ? Border.all(
                                              color: markedDayColors[d]!,
                                              width: 2,
                                            )
                                            : null,
                                  )
                                  : null,
                          alignment: Alignment.center,
                          child: Text(
                            '$d',
                            style: TextStyle(
                              color:
                                  isMarked ? markedDayColors[d] : Colors.black,
                              fontWeight:
                                  isMarked
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child:
                  selectedTasks.isEmpty
                      ? const Center(child: Text('No tasks for this day'))
                      : ListView.separated(
                        itemCount: selectedTasks.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final todo = selectedTasks[index];
                          return Row(
                            children: [
                              Checkbox(
                                value: todo.isDone,
                                onChanged: (val) {
                                  setState(() {
                                    todo.isDone = val ?? false;
                                  });
                                },
                                activeColor: todo.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: BorderSide(
                                  color: todo.color.withOpacity(0.5),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: todo.color,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    todo.notes.isNotEmpty
                                        ? todo.notes
                                        : DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(todo.date),
                                    style: const TextStyle(
                                      color: Color(0xFFB7AFC5),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
