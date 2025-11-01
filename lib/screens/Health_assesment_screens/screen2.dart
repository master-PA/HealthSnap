import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen3.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenSecond extends StatefulWidget {
  const SurveyScreenSecond({super.key});

  @override
  State<SurveyScreenSecond> createState() => _SurveyScreenSecondState();
}

class _SurveyScreenSecondState extends State<SurveyScreenSecond> {
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _dayC = TextEditingController();
  final TextEditingController _monthC = TextEditingController();
  final TextEditingController _yearC = TextEditingController();
  final TextEditingController _heightC = TextEditingController();
  final TextEditingController _weightC = TextEditingController();

  final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _selectedCountry = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _nameC.dispose();
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Image.asset('assets/logo.png', height: 40),

                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      label: const Text('Back'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        padding: EdgeInsets.zero,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const SurveyProgressIndicator(currentStep: 1),

                    const SizedBox(height: 32),

                    const Text(
                      'For better tracking, please provide us few details about you',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 32),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.person_outline,
                        color: Colors.grey[700],
                      ),
                      title: Text(
                        'Your name',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          controller: _nameC,
                          keyboardType: TextInputType.name,
                          decoration: _inputDecoration('Enter name'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.wc_outlined, color: Colors.grey[700]),
                      title: Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _selectedGender,
                          builder: (context, selectedGender, _) {
                            return Row(
                              children: [
                                _buildGenderOption('Male', selectedGender),
                                const SizedBox(width: 24),
                                _buildGenderOption('Female', selectedGender),
                                const SizedBox(width: 24),
                                _buildGenderOption('Other', selectedGender),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.cake_outlined,
                        color: Colors.grey[700],
                      ),
                      title: Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final fieldWidth = (constraints.maxWidth - 100) / 3;

                            return Row(
                              children: [
                                SizedBox(
                                  width: fieldWidth,
                                  child: TextFormField(
                                    controller: _dayC,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: _inputDecoration('DD'),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: fieldWidth,
                                  child: TextFormField(
                                    controller: _monthC,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: _inputDecoration('MM'),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: fieldWidth,
                                  child: TextFormField(
                                    controller: _yearC,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: _inputDecoration('YYYY'),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            initialDate: DateTime(2000),
                                          );
                                      if (pickedDate != null) {
                                        _dayC.text = pickedDate.day
                                            .toString()
                                            .padLeft(2, '0');
                                        _monthC.text = pickedDate.month
                                            .toString()
                                            .padLeft(2, '0');
                                        _yearC.text = pickedDate.year
                                            .toString();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.height, color: Colors.grey[700]),
                      title: Text(
                        'Height',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          controller: _heightC,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration('Enter height in cm'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.monitor_weight_outlined,
                        color: Colors.grey[700],
                      ),
                      title: Text(
                        'Weight',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          controller: _weightC,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration('Enter weight in Kg')
                              .copyWith(
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey[600],
                                ),
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        CupertinoIcons.globe,
                        color: Colors.grey[700],
                      ),
                      title: Text(
                        'Country',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _selectedCountry,
                          builder: (context, selectedCountry, _) {
                            return InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  onSelect: (value) =>
                                      _selectedCountry.value = value.name,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedCountry ?? 'Enter your country',
                                      style: TextStyle(
                                        color: selectedCountry == null
                                            ? Colors.grey[600]
                                            : Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final gender = _selectedGender.value;
                          final country = _selectedCountry.value;

                          if (_nameC.text.isNotEmpty &&
                              gender != null &&
                              _dayC.text.isNotEmpty &&
                              _monthC.text.isNotEmpty &&
                              _yearC.text.isNotEmpty &&
                              _heightC.text.isNotEmpty &&
                              _weightC.text.isNotEmpty &&
                              country != null) {
                            final dob =
                                '${_yearC.text}-${_monthC.text}-${_dayC.text}';

                            UserProfileService().updatePersonalInfo(
                              name: _nameC.text,
                              gender: gender,
                              dob: dob,
                              height: int.parse(_heightC.text),
                              weight: int.parse(_weightC.text),
                              country: country,
                            );

                            UserProfileService().calculateBMI();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SurveyScreenThird(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all the fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, String? selectedGender) {
    final isSelected = selectedGender == gender;
    return InkWell(
      onTap: () => _selectedGender.value = gender,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Color(0xFF2196F3) : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(gender, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
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
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.5),
      ),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
