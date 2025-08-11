import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController controller;

  const NameInputField({super.key, required this.controller});

  final int maxLength = 21;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        inputFormatters: [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(maxLength),
        ],
        decoration: const InputDecoration(
          labelText: 'NAME',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

/// Custom formatter to force uppercase input
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
