import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final bool isMale;
  final void Function(bool) onGenderChanged;

  const GenderSelector({
    super.key,
    required this.isMale,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => onGenderChanged(true),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  isMale ? Colors.blue : Colors.grey[300],
                ),
                foregroundColor: WidgetStateProperty.all(
                  isMale ? Colors.white : Colors.black,
                ),
              ),
              child: const Text('MALE'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => onGenderChanged(false),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  !isMale ? Colors.pink : Colors.grey[300],
                ),
                foregroundColor: WidgetStateProperty.all(
                  !isMale ? Colors.white : Colors.black,
                ),
              ),
              child: const Text('FEMALE'),
            ),
          ),
        ],
      ),
    );
  }
}
