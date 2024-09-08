import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  BlogEditor({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is Missing';
        }
        return null;
      },
    );
  }
}
