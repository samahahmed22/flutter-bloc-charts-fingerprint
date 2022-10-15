import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;

  final VoidCallback onPress;
  LoginButton({
    required this.onPress,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
