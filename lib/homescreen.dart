import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:io';
import 'dart:typed_data';
import 'calendar_screen.dart';
import 'profile_screen.dart';

class ToDo {
  String title;
  String notes;
  DateTime date;
  bool isDone;
  Color color;
  ToDo({
    required this.title,
    required this.notes,
    required this.date,
    this.isDone = false,
    required this.color,
  });
}

List<Color> taskColors = [
  Color(0xFF8B44F7), // purple
  Color(0xFF44B0F7), // blue
  Color(0xFF4ADE80), // green
  Color(0xFFF59E42), // orange
  Color(0xFFF75555), // red
  Color(0xFFB7AFC5), // gray
];

Color getRandomColor() {
  final random = Random();
  return taskColors[random.nextInt(taskColors.length)];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todoList = [
    ToDo(
      title: 'Grocery Shopping',
      notes: 'Tomorrow',
      date: DateTime.now().add(const Duration(days: 1)),
      isDone: false,
      color: getRandomColor(),
    ),
    ToDo(
      title: 'Book Appoitment',
      notes: '',
      date: DateTime(2025, 5, 10),
      isDone: false,
      color: getRandomColor(),
    ),
    ToDo(
      title: 'Homework',
      notes: '',
      date: DateTime(2025, 5, 17),
      isDone: false,
      color: getRandomColor(),
    ),
    ToDo(
      title: 'Event',
      notes: '',
      date: DateTime(2025, 5, 21),
      isDone: false,
      color: getRandomColor(),
    ),
    ToDo(
      title: 'Salon Appoitment',
      notes: '',
      date: DateTime(2025, 5, 30),
      isDone: false,
      color: getRandomColor(),
    ),
    ToDo(
      title: 'Pelulusan MAN 4 Pandeglang',
      notes: '',
      date: DateTime(2025, 6, 18),
      isDone: false,
      color: getRandomColor(),
    ),
  ];

  int _selectedIndex = 0;

  // Data profil
  String profileName = 'Olivia Bennett';
  String profileEmail = 'olivia.bennett@email.com';
  String profileHobbies = '';
  Uint8List? profilePhoto;

  void _onNavTapped(int index) {
    if (index == 1) {
      _showTaskForm();
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarScreen(todoList: todoList),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ProfileScreen(
                name: profileName,
                email: profileEmail,
                hobbies: profileHobbies,
                photoBytes: profilePhoto,
                onSave: (name, email, hobbies, photoBytes) {
                  setState(() {
                    profileName = name;
                    profileEmail = email;
                    profileHobbies = hobbies;
                    profilePhoto = photoBytes;
                  });
                },
              ),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showTaskForm({ToDo? todo, int? index}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final notesController = TextEditingController(text: todo?.notes ?? '');
    DateTime? selectedDate = todo?.date;
    Color color = todo?.color ?? getRandomColor();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFCF9FF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Todo_lly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Task Name',
                  filled: true,
                  fillColor: const Color(0xF2EDE8F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Color(0xFFB7AFC5)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Notes',
                  filled: true,
                  fillColor: const Color(0xF2EDE8F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Color(0xFFB7AFC5)),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Date',
                      filled: true,
                      fillColor: const Color(0xF2EDE8F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(color: Color(0xFFB7AFC5)),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF8B44F7),
                      ),
                    ),
                    controller: TextEditingController(
                      text:
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (todo != null)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xF2EDE8F6),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            todoList.removeAt(index!);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  if (todo != null) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B44F7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            selectedDate == null)
                          return;
                        setState(() {
                          if (todo != null) {
                            todoList[index!] = ToDo(
                              title: titleController.text,
                              notes: notesController.text,
                              date: selectedDate!,
                              isDone: todo.isDone,
                              color: color,
                            );
                          } else {
                            todoList.add(
                              ToDo(
                                title: titleController.text,
                                notes: notesController.text,
                                date: selectedDate!,
                                color: color,
                              ),
                            );
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        todo != null ? 'Save' : 'Create Task',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9FF),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Todo_list',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                _onNavTapped(2);
              },
              child:
                  profilePhoto != null
                      ? CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFE0E0E0),
                        backgroundImage: MemoryImage(profilePhoto!),
                      )
                      : CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFE0E0E0),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Hi $profileName, here's your to-do list",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.separated(
                itemCount: todoList.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final todo = todoList[index];
                  return GestureDetector(
                    onTap: () => _showTaskForm(todo: todo, index: index),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: todo.color,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _getDateLabel(todo.date),
                                style: const TextStyle(
                                  color: Color(0xFFB7AFC5),
                                  fontSize: 15,
                                ),
                              ),
                              if (todo.notes.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    todo.notes,
                                    style: const TextStyle(
                                      color: Color(0xFFB7AFC5),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: todo.isDone,
                          onChanged: (val) {
                            setState(() {
                              todo.isDone = val ?? false;
                            });
                          },
                          activeColor: const Color(0xFF8B44F7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(color: Color(0xFFB7AFC5)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFCF9FF),
        elevation: 0,
        selectedItemColor: const Color(0xFF8B44F7),
        unselectedItemColor: const Color(0xFFB7AFC5),
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
