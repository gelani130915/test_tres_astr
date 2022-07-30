import 'package:flutter/material.dart';

class RoudedButton extends StatefulWidget {
  String text;
  VoidCallback onPressed;
  bool isSlected;
  RoudedButton({Key? key, required this.text, required this.onPressed, this.isSlected = false}) : super(key: key);

  @override
  State<RoudedButton> createState() => _RoudedButtonState();
}

class _RoudedButtonState extends State<RoudedButton> {
  @override
  Widget build(BuildContext context) { 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Text(
            widget.text, 
            style: TextStyle( 
              fontSize: 17, 
              color: widget.isSlected ? Colors.white : Colors.black
            )
          ),
        ),
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom( 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),  
          ),
          primary: widget.isSlected ? Colors.orange : Colors.white,
          elevation: 4
      ),
      ),
    );
  }
}