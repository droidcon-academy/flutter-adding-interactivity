import 'package:flutter/material.dart';

class SpeedScreen extends StatefulWidget {
  const SpeedScreen({super.key});

  @override
  State<SpeedScreen> createState() => _SpeedScreenState();
}

class _SpeedScreenState extends State<SpeedScreen> {
  final List<String> measures = ['Metric', 'Imperial'];
  double distance = 0;
  double time = 0;
  String selectedUnit = 'Metric';
  double speed = 0;
  String message = '';
  final TextEditingController txtDistance = TextEditingController();
  final TextEditingController txtTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Speed Calculator')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  //color: Colors.grey.shade800),
                  decoration: InputDecoration(labelText: 'Distance'),
                  controller: txtDistance,
                ),
                const Divider(
                  height: 32,
                  color: Colors.transparent,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  decoration:
                      const InputDecoration(labelText: 'Time in minutes'),
                  controller: txtTime,
                ),
                const Divider(
                  height: 32,
                  color: Colors.transparent,
                ),
                DropdownButton<String>(
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value ?? 'Metric';
                    });
                  },
                  value: selectedUnit,
                  items: measures.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade800),
                        ));
                  }).toList(),
                ),
                const Divider(
                  height: 32,
                  color: Colors.transparent,
                ),
                ElevatedButton(
                    onPressed: () {
                      distance = double.tryParse(txtDistance.text) ?? 0;
                      time = double.tryParse(txtTime.text) ?? 0;
                      speed = calculateSpeed(distance, time);
                      if (speed > 0 && speed.isFinite) {
                        setState(() {
                          message =
                              'Your average speed is ${speed.toStringAsFixed(2)} ${selectedUnit == 'Metric' ? 'km/h' : 'mph'}';
                        });
                      } else {
                        const snackBar = SnackBar(
                            content: Text(
                                'Invalid input. Please check your time and distance values'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text(
                      'Calculate Speed',
                      style: TextStyle(fontSize: 16),
                    )),
                const Divider(
                  height: 32,
                  color: Colors.transparent,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 24, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
        ));
  }

  double calculateSpeed(double distance, double time) {
    double timeInHr = time / 60;
    double speed = distance / timeInHr;
    return speed;
  }

  @override
  void dispose() {
    txtDistance.dispose();
    txtTime.dispose();
    super.dispose();
  }
}
