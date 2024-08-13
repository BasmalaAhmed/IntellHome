import 'package:Intell_Home/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class GasWidget extends StatefulWidget {
  const GasWidget({super.key});

  @override
  _GasWidgetState createState() => _GasWidgetState();
}

class _GasWidgetState extends State<GasWidget> {
  String gasData = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchGasData();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchGasData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchGasData() async {
    final response = await http.get(Uri.parse('http://192.168.4.1:80/gas'));
    if (response.statusCode == 200) {
      setState(() {
        gasData = response.body;
      });
    } else {
      setState(() {
        gasData = 'Failed to load gas data';
      });
    }
  }

  double _getGasValue() {
    try {
      return double.parse(gasData);
    } catch (e) {
      return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                    title: const Text(''),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color:  Color(0xff112D4E)),
                      onPressed: () => Navigator.of(context).pop(),
                      iconSize: 35,
                    ),
                    backgroundColor: const Color(0xffabbfe3), 
                  ),
      body: Stack(
        children: [
          const BackGroundWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: const Text(
                  'Gas Data',
                  style: TextStyle(
                    color: Color(0xff1C3756),
                    decoration:TextDecoration.none,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
                
              ),
              const SizedBox(height: 15.0),
              SfRadialGauge(
                  // title: GaugeTitle(
                  //   text: "Value: ${_getGasValue()}",
                  //   textStyle: TextStyle(
                  //     fontSize: 26,
                  //     fontFamily: "Archivo",
                  //     fontWeight: FontWeight.w600,
                  //     color: Color(0xff112D4E),
                  //   ),
                  //   alignment: GaugeAlignment.center,
                  // ),
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      axisLineStyle: const AxisLineStyle(thickness: 30),
                      showTicks: false,
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: _getGasValue(),
                          enableAnimation: true,
                          needleStartWidth: 0,
                          needleEndWidth: 5,
                          needleColor: Colors.white,
                          knobStyle: const KnobStyle(
                            color: Color(0xFFDADADA),
                            borderColor: Colors.white,
                            knobRadius: 0.06,
                            borderWidth: 0.04,
                          ),
                          tailStyle: const TailStyle(
                            color: Colors.white,
                            width: 5,
                            length: 0.15,
                          ),
                        ),
                        RangePointer(
                          value: _getGasValue(),
                          width: 30,
                          enableAnimation: true,
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}
