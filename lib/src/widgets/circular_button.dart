import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  IconData icon;
  VoidCallback presed;
  double padding;
  double iconSize;
  CircularButton({Key? key, required this.icon, required this.presed, this.padding = 1.0, this.iconSize = 24.0}) : super(key: key);

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> { 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(  
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Icon(widget.icon, color: Colors.black, size: widget.iconSize),
      ),
      onPressed: widget.presed, 
      style: ElevatedButton.styleFrom( 
          shape: const CircleBorder(), 
          primary: Colors.white,
          elevation: 4
      ),
    );
  }
}