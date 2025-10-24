//FOR MY EASY I CREATED THIS TO JUST COPY AND IMPLEMENT


                            // TextFormField(
                            //   controller: _phonec,
                            //   keyboardType: TextInputType.phone,
                            //   decoration: const InputDecoration(
                            //     labelText: "Phone Number",
                            //     prefixIcon: Icon(Icons.phone_rounded),
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Enter your phone number";
                            //     }
                            //     if (value.length < 10) {
                            //       return "Enter a valid phone number";
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // const SizedBox(height: 20),

                            // TextFormField(
                            //   controller: _agec,
                            //   keyboardType: TextInputType.number,
                            //   decoration: const InputDecoration(
                            //     labelText: "Age",
                            //     prefixIcon: Icon(Icons.calendar_today_rounded),
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Enter your age";
                            //     }
                            //     final age = int.tryParse(value);
                            //     if (age == null || age < 1 || age > 120) {
                            //       return "Enter a valid age";
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // const SizedBox(height: 20),

                            // DropdownButtonFormField<String>(
                            //   value: genderValue,
                            //   decoration: const InputDecoration(
                            //     labelText: "Gender",
                            //     prefixIcon: Icon(Icons.wc_rounded),
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   items: [
                            //     DropdownMenuItem(
                            //       value: 'Male',
                            //       child: Text('Male'),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: 'Female',
                            //       child: Text('Female'),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: 'Others',
                            //       child: Text('Other'),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: 'Prefer not to say',
                            //       child: Text('Prefer not to say'),
                            //     ),
                            //   ],
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       genderValue = newValue;
                            //     });
                            //   },
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Please select your gender";
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // const SizedBox(height: 20),

                            // TextFormField(
                            //   controller: _locationc,
                            //   keyboardType: TextInputType.streetAddress,
                            //   decoration: const InputDecoration(
                            //     labelText: "Current Location",
                            //     prefixIcon: Icon(Icons.location_on_rounded),
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Enter your current location";
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // const SizedBox(height: 20),

                             // TextFormField(
                            //   controller: _userNamec,
                            //   keyboardType: TextInputType.text,
                            //   decoration: const InputDecoration(
                            //     labelText: "Username",
                            //     prefixIcon: Icon(Icons.account_circle_rounded),
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Enter a username";
                            //     }
                            //     if (value.length < 3) {
                            //       return "Username must be at least 3 characters";
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // const SizedBox(height: 20),

// Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _agec,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: "Age (20-120 years)",
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Enter your age";
//                   }
//                   final age = int.tryParse(value);
//                   if (age == null || age < 20 || age > 120) {
//                     return "Age must be between 20-120";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),

//               TextFormField(
//                 controller: _heightc,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: "Height (120-210 cm)",
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.height),
//                   suffixText: "cm",
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Enter your height";
//                   }
//                   final height = int.tryParse(value);
//                   if (height == null || height < 120 || height > 210) {
//                     return "Height must be between 120-210 cm";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),

//               TextFormField(
//                 controller: _weightc,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: "Weight (30-250 kg)",
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.monitor_weight),
//                   suffixText: "kg",
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Enter your weight";
//                   }
//                   final weight = int.tryParse(value);
//                   if (weight == null || weight < 30 || weight > 250) {
//                     return "Weight must be between 30-250 kg";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),

//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       Icon(Icons.smoking_rooms, color: Colors.grey),
//                       SizedBox(width: 12),
//                       Expanded(child: Text("Do you smoke?")),
//                       Checkbox(
//                         value: isSmoking,
//                         onChanged: (value) {
//                           setState(() {
//                             isSmoking = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),

//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Family history of heart disease?"),
//                       SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ChoiceChip(
//                               avatar: Icon(Icons.check),
//                               label: const Text("Yes"),
//                               selected: familyHistory == "yes",
//                               onSelected: (selected) {
//                                 setState(() {
//                                   familyHistory = "yes";
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: ChoiceChip(
//                               avatar: Icon(Icons.clear),
//                               label: const Text("No"),
//                               selected: familyHistory == "no",
//                               onSelected: (selected) {
//                                 setState(() {
//                                   familyHistory = "no";
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: ChoiceChip(
//                               label: const Text("Don't know"),
//                               selected: familyHistory == "dont_know",
//                               onSelected: (selected) {
//                                 setState(() {
//                                   familyHistory = "dont_know";
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text("Get Recommendations"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),