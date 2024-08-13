import 'package:flutter/material.dart';

class DaylightAndMotionDetectors extends StatefulWidget {
  const DaylightAndMotionDetectors({
    super.key,
  });

  @override
  State<DaylightAndMotionDetectors> createState() =>
      _DaylightAndMotionDetectorsState();
}

class _DaylightAndMotionDetectorsState
    extends State<DaylightAndMotionDetectors> {
  bool isDaylightDectorEnabled = false;
  bool isMotionDectorEnabled = false;

  void onDayLightDectorChanged() {
    setState(() {
      isDaylightDectorEnabled = !isDaylightDectorEnabled;
    });
  }

  void onMotionDetectorChanged() {
    setState(() {
      isMotionDectorEnabled = !isMotionDectorEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 35),
          width: 210,
          child: const Divider(
            thickness: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xffFFD700),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              const Text(
                'Daylight Detector',
                style: TextStyle(
                  color: Color(0xff4F4F4F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              const Spacer(),
              Switch(
                value: isDaylightDectorEnabled,
                activeColor: Colors.black,
                inactiveTrackColor: Colors.grey,
                trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                thumbColor: const WidgetStatePropertyAll(Colors.white),
                onChanged: (value) {
                  onDayLightDectorChanged();
                },
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 35),
          width: 210,
          child: const Divider(
            thickness: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xffFF2700).withOpacity(0.74),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const Text(
                'Motion Detector',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              const Spacer(),
              Switch(
                value: isMotionDectorEnabled,
                inactiveTrackColor: Colors.grey,
                trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                thumbColor: const WidgetStatePropertyAll(Colors.white),
                onChanged: (value) {
                  onMotionDetectorChanged();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
