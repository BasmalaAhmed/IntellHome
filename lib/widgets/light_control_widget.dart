import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class LightControlWidget extends StatefulWidget {
  const LightControlWidget({super.key});

  @override
  _LightControlWidgetState createState() => _LightControlWidgetState();
}

class _LightControlWidgetState extends State<LightControlWidget> {
  Timer? _timer;
  bool room1Light = false;
  bool room2Light = false;
  bool room3Light = false;
  bool room4Light = false;

  Future<void> _fetchautolightData() async {
    final response = await http.get(Uri.parse('http://192.168.4.1:80/auto'));
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void toggleLight(int roomNumber, bool newState) async {
    String url =
        'http://192.168.4.1:80/update?relay=$roomNumber&state=${newState ? 1 : 0}';
    print('Request URL: $url');

    try {
      await http.get(Uri.parse(url));
      setState(() {
        switch (roomNumber) {
          case 1:
            room1Light = newState;
            break;
          case 2:
            room2Light = newState;
            break;
          case 3:
            room3Light = newState;
            break;
          case 4:
            room4Light = newState;
            break;
        }
      });
    } catch (e) {
      print('Error toggling light: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchautolightData();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchautolightData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xff0078D4).withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Text(
            'Light Sensor',
            style: TextStyle(
              color: Color.fromARGB(255, 1, 70, 126),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Row(
          children: [
            buildRoomSwitch(1, 'Room 1', room1Light),
            const Spacer(),
            buildRoomSwitch(2, 'Room 2', room2Light),
          ],
        ),
        const SizedBox(height: 40.0),
        Row(
          children: [
            buildRoomSwitch(3, 'Room 3', room3Light),
            const Spacer(),
            buildRoomSwitch(4, 'Room 4', room4Light),
          ],
        ),
      ],
    );
  }

  Widget buildRoomSwitch(int roomNumber, String roomName, bool value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          roomName,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 38, 70),
            fontSize: 20.0,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 5.0),
        LiteRollingSwitch(
          value: value,
          onChanged: (newValue) {
            toggleLight(roomNumber, newValue);
          },
          colorOn: Colors.blue,
          width: 87,
          colorOff: const Color.fromARGB(255, 130, 128, 128),
          iconOn: Icons.lightbulb_outline,
          iconOff: Icons.power_settings_new,
          onDoubleTap: () {},
          onSwipe: () {},
          onTap: () {},
        ),
      ],
    );
  }
}
