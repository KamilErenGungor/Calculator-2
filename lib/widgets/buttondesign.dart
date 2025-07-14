import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color fillcolor;
  final Color textcolor;
  final double textsize;
  final Function(String) clicking;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.fillcolor,
    required this.textcolor,
    required this.textsize,
    required this.clicking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Her butonun genişlik ve yüksekliği eşit ve 70x70 olacak şekilde ayarlanmıştır.
    return Container(
      margin: const EdgeInsets.all(6),
      child: SizedBox(
        width: 70,
        height: 70,
        child: ElevatedButton(
          onPressed: () => clicking(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: fillcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.zero, // padding yerine sizedBox boyutu kullandık
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: textsize,
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
