
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  static const Color ink = Color(0xFF292821);
  static const Color muted = Color(0xFF77736C);
  static const Color border = Color(0xFFE4DED2);
  static const Color paper = Color(0xFFFFFDF9);
  static const Color accent = Color(0xFFB65E45);

  @override
  Widget build(BuildContext context) {
    final isTitle = hintText.toLowerCase().contains('title');

    return TextFormField(
      controller: controller,
      keyboardType: isTitle
          ? TextInputType.text
          : TextInputType.multiline,
      textCapitalization: isTitle
          ? TextCapitalization.sentences
          : TextCapitalization.sentences,
      textInputAction:
          isTitle ? TextInputAction.next : TextInputAction.newline,
      minLines: isTitle ? 1 : 8,
      maxLines: isTitle ? 2 : null,
      style: TextStyle(
        color: ink,
        fontSize: isTitle ? 20 : 16,
        fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
        height: 1.7,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: muted,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: paper,
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: accent,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Field cannot be empty';
        }

        if (isTitle && value.trim().length < 3) {
          return 'Title must contain at least 3 characters';
        }

        return null;
      },
    );
  }
}
