import 'package:flutter/material.dart';

class GradientSliderWidget extends StatefulWidget {
  final Function(double) onValueChanged;

  const GradientSliderWidget({super.key, required this.onValueChanged});

  @override
  GradientSliderState createState() => GradientSliderState();
}

class GradientSliderState extends State<GradientSliderWidget> {
  double _sliderValue = 0.0; // Slider value, initially set to 0.0

  bool _hasExceededThreshold = false;

  void _onThresholdExceeded() {
    if (!_hasExceededThreshold) {
      setState(() {
        _hasExceededThreshold = true;
      });
      print("Slider value exceeded 80%! Perform an action here.");
      // Call any action or function you want here
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Update the slider value on user interaction (dragging)
      onPanUpdate: (details) {
        setState(() {
          // Normalize the slider value based on horizontal position
          _sliderValue =
              (details.localPosition.dx / MediaQuery.of(context).size.width)
                  .clamp(0.0, 1.0); // Ensure the value is between 0 and 1
        });
        widget.onValueChanged(_sliderValue);

        // Trigger action if the slider value exceeds 80%
        if (_sliderValue > 0.8) {
          _onThresholdExceeded();
        }
      },
      child: CustomPaint(
        size: const Size(double.infinity, 60), // Adjust size as needed
        painter: GradientSliderPainter(
          value: _sliderValue,
        ),
      ),
    );
  }
}

class GradientSliderPainter extends CustomPainter {
  final double value;

  GradientSliderPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the selected gradient line (green gradient)
    final Paint selectedGradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF00D179), // Green color
          Color(0xFF00D179), // Dark Green color
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width * value, size.height))
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    // Paint for the unselected gradient line (original gradient)
    final Paint unselectedGradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFCDCDFF),
          Colors.white,
          Color(0xFF9999D4),
          Color(0xAA150030)
        ],
      ).createShader(Rect.fromLTWH(
          size.width * value, 0, size.width * (1 - value), size.height))
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    // Paint for the thumb
    final Paint thumbPaint = Paint()
      ..color = const Color(0xFF1A1A53)
      ..style = PaintingStyle.fill;

    // Draw the selected gradient line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width * value, size.height / 2),
      selectedGradientPaint,
    );

    // Draw the unselected gradient line
    canvas.drawLine(
      Offset(size.width * value, size.height / 2),
      Offset(size.width, size.height / 2),
      unselectedGradientPaint,
    );

    // Draw the thumb circle
    canvas.drawCircle(
      Offset(size.width * value, size.height / 2),
      25,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
