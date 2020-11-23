import 'package:flutter/material.dart'; 
class TextFieldDec {
  static InputDecoration inputDec(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      fillColor: Colors.transparent,
      filled: true,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white),      
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }
}