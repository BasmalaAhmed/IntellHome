import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Auto extends StatefulWidget {
  const Auto({super.key});

  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends State<Auto> {
  Timer? _timer;
  String pirData = "0";

  @override
  void initState() {
    super.initState();
    _fetchPirData();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchPirData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _fetchPirData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.4.1:80/pir'));
      if (response.statusCode == 200) {
        setState(() {
          pirData = response.body;
        });
      }
    } catch (e) {
      // Handle errors
      setState(() {
        pirData = "Error fetching data";
      });
    }
  }

  String _detect() {
    return pirData == "1" ? "Move detected" : "No move detected";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Data'),
      ),
      body: Center(
        child: Text(_detect()),
      ),
    );
  }
}
