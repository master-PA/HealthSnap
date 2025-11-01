import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: reminders.isEmpty
              ? buildEmptyState(context)
              : buildReminderList(context),
        ),
      ),
    );
  }

  Widget buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "🔔 My Reminders",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          "You haven’t set any reminder yet !",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        const Text(
          "Start by adding your first medication or wellness activity",
          style: TextStyle(fontSize: 14, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () => openAddReminder(context),
          icon: const Icon(Icons.add),
          label: const Text("Add New Reminder"),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFE9EEFF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget buildReminderList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🔔 My Reminders",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(reminder['name']),
                  subtitle: Text(
                    "${reminder['time'].format(context)} | ${reminder['days']}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      setState(() => reminders.removeAt(index));
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: OutlinedButton.icon(
            onPressed: () => openAddReminder(context),
            icon: const Icon(Icons.add),
            label: const Text("Add New Reminder"),
          ),
        ),
      ],
    );
  }

  void openAddReminder(BuildContext context) {
    TextEditingController nameC = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();
    List<bool> selectedDays = [false, false, false, false, false, false, false];
    bool everyday = false;

    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🔔 My reminders",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Reminder name"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: nameC,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Reminder times"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Switch.adaptive(
                            value: true,
                            onChanged: (_) {},
                            activeColor: Colors.blue,
                          ),
                          TextButton(
                            onPressed: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (pickedTime != null) {
                                setStateDialog(() => selectedTime = pickedTime);
                              }
                            },
                            child: Text(
                              selectedTime.format(context),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (index) {
                          return GestureDetector(
                            onTap: () {
                              setStateDialog(() {
                                selectedDays[index] = !selectedDays[index];
                                everyday = selectedDays.every((d) => d);
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedDays[index]
                                    ? Colors.blue
                                    : Colors.grey[300],
                              ),
                              child: Center(
                                child: Text(
                                  dayLabels[index],
                                  style: TextStyle(
                                    color: selectedDays[index]
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: everyday,
                            onChanged: (value) {
                              setStateDialog(() {
                                everyday = value ?? false;
                                for (int i = 0; i < 7; i++) {
                                  selectedDays[i] = everyday;
                                }
                              });
                            },
                          ),
                          const Text("Everyday"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final selectedDayNames = everyday
                              ? "Everyday"
                              : dayLabels
                                    .asMap()
                                    .entries
                                    .where(
                                      (entry) =>
                                          selectedDays[entry.key] == true,
                                    )
                                    .map((entry) => entry.value)
                                    .join(", ");
                          if (nameC.text.isNotEmpty) {
                            setState(() {
                              reminders.add({
                                'name': nameC.text,
                                'time': selectedTime,
                                'days': selectedDayNames,
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Save Reminder",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
