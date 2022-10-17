import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;

  final VoidCallback onPress;
  SubmitButton({
    required this.onPress,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(110, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}
