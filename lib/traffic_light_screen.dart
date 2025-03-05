import 'dart:async';
import 'package:flutter/material.dart';
import 'traffic_light_widget.dart';

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _lightState = 0;
  bool _isAutoMode = false;
  Timer? _timer;
  int _remainingTime = 0;

  void _changeLight() {
    setState(() {
      _lightState = (_lightState + 1) % 3;
      _remainingTime = _lightState == 0 || _lightState == 2 ? 10 : 3;
    });
  }

  void _toggleAutoMode() {
    if (_isAutoMode) {
      _timer?.cancel();
      setState(() {
        _isAutoMode = false;
      });
    } else {
      _startAutoMode();
      setState(() {
        _isAutoMode = true;
      });
    }
  }

  void _startAutoMode() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          if (_lightState == 0) {
            _lightState = 1;
            _remainingTime = 3;
          } else if (_lightState == 1) {
            _lightState = 2;
            _remainingTime = 10;
          } else if (_lightState == 2) {
            _lightState = 0;
            _remainingTime = 10;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traffic Light Animation')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 204, 245, 1),
              const Color.fromARGB(255, 161, 3, 189),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // แสดงเวลาที่เหลือด้านบนของสัญญาณไฟ
              if (_isAutoMode)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    '$_remainingTime',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TrafficLightWidget(color: const Color.fromARGB(255, 249, 18, 2), isActive: _lightState == 0),
                    const SizedBox(height: 20),
                    TrafficLightWidget(color: const Color.fromARGB(255, 246, 221, 2), isActive: _lightState == 1),
                    const SizedBox(height: 20),
                    TrafficLightWidget(color: const Color.fromARGB(241, 0, 232, 8), isActive: _lightState == 2),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _changeLight,
                child: const Text('เปลี่ยนสัญญาณไฟ'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleAutoMode,
                child: Text(_isAutoMode ? 'ยกเลิกโหมดอัตโนมัติ' : 'เปิดโหมดอัตโนมัติ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
