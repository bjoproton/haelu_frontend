// External
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Internal

class TextString extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  
  TextString({
      required this.text,
      this.color = Colors.black,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.bebasNeue(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}

class TextHeading extends TextString {
  TextHeading({
      required text,
      color = Colors.black,
  }) : super(
    text: text,
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 50,
  );
}

class TextSubHeading extends TextString {
  TextSubHeading({
      required text,
      color = Colors.black,
  }) : super(
    text: text,
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );
}

class TextNormal extends TextString {
  TextNormal({
      required text,
      color = Colors.black,
  }) : super(
    text: text,
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
}

class TextSmall extends TextString {
  TextSmall({
      required text,
      color = Colors.black,
  }) : super(
    text: text,
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}
