import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen3.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenSecond extends StatefulWidget {
  const SurveyScreenSecond({super.key});

  @override
  State<SurveyScreenSecond> createState() => _SurveyScreenSecondState();
}

class _SurveyScreenSecondState extends State<SurveyScreenSecond> {
  final TextEditingController _dayC = TextEditingController();
  final TextEditingController _monthC = TextEditingController();
  final TextEditingController _yearC = TextEditingController();
  final TextEditingController _heightC = TextEditingController();
  final TextEditingController _weightC = TextEditingController();

  final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _selectedCountry = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _dayC.dispose();
    _monthC.dispose();
    _yearC.dispose();
    _heightC.dispose();
    _weightC.dispose();

    _selectedGender.dispose();
    _selectedCountry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: "Screen1",
        child: Column(
          children: [
            Container(
              color: const Color(0xFFEE9B7B),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo.png', height: 80),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const SurveyProgressIndicator(currentStep: 1),
                      const SizedBox(height: 20),
                      const Text(
                        'For Better Tracking, Please provide us few more details',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<String?>(
                        valueListenable: _selectedGender,
                        builder: (context, selectedGender, _) {
                          return ListTile(
                            leading: const Icon(Icons.male),
                            title: const Text(
                              'Gender',
                              style: TextStyle(color: Colors.grey),
                            ),
                            subtitle: Row(
                              children: [
                                Radio<String>(
                                  value: "Male",
                                  groupValue: selectedGender,
                                  activeColor: Colors.blue,
                                  onChanged: (value) =>
                                      _selectedGender.value = value,
                                ),
                                const Text("Male"),
                                Radio<String>(
                                  value: "Female",
                                  groupValue: selectedGender,
                                  activeColor: Colors.blue,
                                  onChanged: (value) =>
                                      _selectedGender.value = value,
                                ),
                                const Text("Female"),
                                Radio<String>(
                                  value: "Other",
                                  groupValue: selectedGender,
                                  activeColor: Colors.blue,
                                  onChanged: (value) =>
                                      _selectedGender.value = value,
                                ),
                                const Text("Other"),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text(
                          'Date of Birth',
                          style: TextStyle(color: Colors.grey),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: _dayC,
                                decoration: _inputDecoration("DD"),
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: _monthC,
                                decoration: _inputDecoration("MM"),
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: _yearC,
                                decoration: _inputDecoration("YYYY"),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                if (pickedDate != null) {
                                  _dayC.text = pickedDate.day.toString();
                                  _monthC.text = pickedDate.month.toString();
                                  _yearC.text = pickedDate.year.toString();
                                }
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.height),
                        title: const Text(
                          'Height',
                          style: TextStyle(color: Colors.grey),
                        ),
                        subtitle: SizedBox(
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _heightC,
                            decoration: _inputDecoration(
                              "Enter your Height in cm",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.scale),
                        title: const Text(
                          'Weight',
                          style: TextStyle(color: Colors.grey),
                        ),
                        subtitle: SizedBox(
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _weightC,
                            decoration: _inputDecoration(
                              "Enter your Weight in kg",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<String?>(
                        valueListenable: _selectedCountry,
                        builder: (context, selectedCountry, _) {
                          return ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                showCountryPicker(
                                  context: context,
                                  onSelect: (value) =>
                                      _selectedCountry.value = value.name,
                                );
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                            leading: const Icon(CupertinoIcons.globe),
                            title: const Text(
                              'Country',
                              style: TextStyle(color: Colors.grey),
                            ),
                            subtitle: SizedBox(
                              width: 200,
                              child: Text(
                                selectedCountry ?? "Select your country",
                                style: TextStyle(
                                  color: selectedCountry == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      Hero(
                        tag: "Screen2",
                        child: ElevatedButton(
                          onPressed: () {
                            final gender = _selectedGender.value;
                            final country = _selectedCountry.value;

                            if (gender != null && country != null) {
                              print('All fields filled!');
                              print('Country: $country');
                              print('Gender: $gender');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SurveyScreenThird(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all the fields'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintText: hint,
    );
  }
}
