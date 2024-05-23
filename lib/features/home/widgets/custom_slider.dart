import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../../utils/constants/colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.smiNumber,
  });

  final String title;
  final double min, max;
  final SMINumber? smiNumber;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, bottom: 14),
      child: Container(
        height: 120,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.seekBarBackground.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 3,),
            Text(
              widget.title,
              style: TextStyle(
                color: AppColors.seekBarBackground.withOpacity(0.5),
                fontSize: 20,
                fontFamily: 'Demo',
                fontWeight: FontWeight.w600,
              ),
            ),

            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (details.delta.dy > 0) {
                    // Swiped up
                    _value = _value + 1 <= widget.max ? _value + 1 : widget.max;
                  } else {
                    // Swiped down
                    _value = _value - 1 >= widget.min ? _value - 1 : widget.min;
                  }
                  widget.smiNumber!.value = _value;
                });
              },
              child: Text(
                _value.round().toString(),
                style: const TextStyle(
                  fontFamily: 'Demo',
                  fontSize: 40,
                  color: AppColors.seekBarBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3,),
          ],
        ),
      ),
    );
  }
}