import 'package:flutter/material.dart';
import 'package:mymeds_app/components/common_buttons.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  String _result = '';

  void _checkBloodPressure() {
    if (_formKey.currentState!.validate()) {
      final int systolic = int.parse(_systolicController.text);
      final int diastolic = int.parse(_diastolicController.text);

      if (systolic < 90 || diastolic < 60) {
        _result = 'Low Blood Pressure';
      } else if (systolic <= 120 && diastolic <= 80) {
        _result = 'Normal Blood Pressure';
      } else if (systolic <= 139 || diastolic <= 89) {
        _result = 'Prehypertension';
      } else if (systolic <= 159 || diastolic <= 99) {
        _result = 'Hypertension Stage 1';
      } else {
        _result = 'Hypertension Stage 2';
      }

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Pressure Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Blood pressure is the measurement of the pressure or force of blood inside your arteries. Each time your heart beats, it pumps blood into arteries that carry blood throughout your body.",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Normal blood pressure of human is 120/80 mmHg.',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                const Text('Systolic: 120 mmHg and Diastolic: 80 mmHg',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter your blood pressure values:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _systolicController,
                  decoration: const InputDecoration(
                    labelText: 'Systolic Pressure',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter systolic pressure';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _diastolicController,
                  decoration: const InputDecoration(
                    labelText: 'Diastolic Pressure',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter diastolic pressure';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CommonButtons(
                  onTap: _checkBloodPressure,
                  textLabel: 'Check Blood Pressure',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  "You have $_result.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _result == 'Normal Blood Pressure'
                        ? Colors.green
                        : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
