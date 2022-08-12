import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    Key? key,
    required this.controller,
    required this.node,
    required this.label,
    this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode node;
  final String label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        controller: controller,
        focusNode: node,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }

          return null;
        },
      ),
    );
  }
}
