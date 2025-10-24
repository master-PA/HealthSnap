import "package:flutter/material.dart";
import "package:healthsnap_app/screens/Health_assesment_screens/screen4.dart";
import "package:healthsnap_app/widgets/survey3_helper.dart";
import "package:healthsnap_app/widgets/survey_progress_indicator.dart";

class SurveyScreenThird extends StatefulWidget {
  const SurveyScreenThird({super.key});

  @override
  State<SurveyScreenThird> createState() => _SurveyScreenThirdState();
}

class _SurveyScreenThirdState extends State<SurveyScreenThird> {
  String? dietType;
  String? sleepQuality;
  String? hydrationLevel;
  String? stressLevel;
  String? smoking;
  String? alcoholIntake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SurveyProgressIndicator(currentStep: 2),
              const SizedBox(height: 20),
              const Text(
                'How does each of these statements related to you?',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text(
                "Select one answer for each statement",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Diet type",
                first: "Vegan",
                second: "Vegetarian",
                third: "Non vegetarian",
                noOfOptions: 3,
                selectedValue: dietType,
                onChanged: (value) {
                  setState(() {
                    dietType = value;
                  });
                },
              ),

              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Sleep quality",
                first: "Low",
                second: "Normal",
                third: "High",
                noOfOptions: 3,
                selectedValue: sleepQuality,
                onChanged: (value) {
                  setState(() {
                    sleepQuality = value;
                  });
                },
              ),

              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Hydration level",
                first: "Low",
                second: "Normal",
                third: "High",
                noOfOptions: 3,
                selectedValue: hydrationLevel,
                onChanged: (value) {
                  setState(() {
                    hydrationLevel = value;
                  });
                },
              ),

              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Stress level",
                first: "Low",
                second: "Normal",
                third: "High",
                noOfOptions: 3,
                selectedValue: stressLevel,
                onChanged: (value) {
                  setState(() {
                    stressLevel = value;
                  });
                },
              ),

              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Smoking",
                first: "Yes",
                second: "No",
                third: "",
                noOfOptions: 2,
                selectedValue: smoking,
                onChanged: (value) {
                  setState(() {
                    smoking = value;
                  });
                },
              ),

              Divider(color: Colors.grey),
              const SizedBox(height: 20),

              SurveySingleOption(
                title: "Alcohol intake",
                first: "Occasionally",
                second: "Regularly",
                third: "Never",
                noOfOptions: 3,
                selectedValue: alcoholIntake,
                onChanged: (value) {
                  setState(() {
                    alcoholIntake = value;
                  });
                },
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if (dietType != null &&
                      sleepQuality != null &&
                      hydrationLevel != null &&
                      stressLevel != null &&
                      smoking != null &&
                      alcoholIntake != null) {
                    print('All questions answered!');
                    print('Diet: $dietType');
                    print('Sleep: $sleepQuality');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyScreenFourth(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please answer all questions'),
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
            ],
          ),
        ),
      ),
    );
  }
}
