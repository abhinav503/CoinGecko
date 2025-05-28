import 'package:coingecko/core/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(color: greyColor),
        filled: true,
        errorStyle: const TextStyle(height: 0.2, fontSize: 12),
        errorMaxLines: 1,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
