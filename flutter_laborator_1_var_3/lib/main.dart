import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Viteză Medie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeedCalculator(),
    );
  }
}

class SpeedCalculator extends StatefulWidget {
  @override
  _SpeedCalculatorState createState() => _SpeedCalculatorState();
}

class _SpeedCalculatorState extends State<SpeedCalculator> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  double _speed = 0.0;

  void _calculateSpeed() {
    final double distance = double.tryParse(_distanceController.text) ?? 0;
    final double time = double.tryParse(_timeController.text) ?? 1;

    if (time > 0) {
      setState(() {
        _speed = distance / time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Viteză Medie'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input pentru distanță
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Distanța (km)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),

            SizedBox(height: 20),

            // Input pentru timp
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Timpul (ore)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.access_time),
              ),
            ),

            SizedBox(height: 30),

            // Buton de calcul
            ElevatedButton(
              onPressed: _calculateSpeed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Calculează Viteza',
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 30),

            // Afișare rezultat
            Card(
              elevation: 5,
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Viteza medie: ${_speed.toStringAsFixed(2)} km/h',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
