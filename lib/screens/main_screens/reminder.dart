import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController _nameC = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSelected = false;
  List<bool> selectedList = [false, false, false, false, false, false, false];
  final List<String> dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thru',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[100]!, Colors.orange],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "🔔 My Reminders ",
            style: TextStyle(color: Color(0xFF041E7D), fontSize: 30),
          ),
          const SizedBox(height: 20),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlertDialog.adaptive(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text("Reminder name"),
                            const SizedBox(width: 12),
                            TextFormField(
                              controller: _nameC,
                              decoration: InputDecoration(
                                hintText: "Type here",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Reminder times"),
                            const SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                border: BoxBorder.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Switch.adaptive(
                                        activeThumbColor: Colors.green,
                                        inactiveThumbColor: Colors.grey,
                                        value: isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            isSelected = !isSelected;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 16),
                                      TextButton(
                                        onPressed: () async {
                                          final TimeOfDay? timeOfDay =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: selectedTime,
                                              );

                                          if (timeOfDay != null) {
                                            setState(() {
                                              selectedTime = timeOfDay;
                                            });
                                          }
                                        },
                                        child: Text(
                                          "${selectedTime.hour}:${selectedTime.minute}",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  datePicker(),
                                  const SizedBox(height: 20),
                                  Text("Set reminder day & time"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text("Add New Reminder +"),
          ),
        ],
      ),
    );
  }

  Widget datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedList[index] = !selectedList[index];
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedList[index] ? Colors.blue : Colors.grey[300],
            ),
            child: Center(
              child: Text(
                dayLabels[index],
                style: TextStyle(
                  color: selectedList[index] ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
