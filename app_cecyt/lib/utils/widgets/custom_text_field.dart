import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hint,
    required this.label,
    required this.onSave,
    required this.maxLength,
    required this.controller,
    required this.validator,
    required this.keyboard,
    super.key,
  });
  final String hint;
  final String label;
  final void Function(String? text) onSave;
  final int maxLength;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboard;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
        // gradient: const LinearGradient(
        //   // stops: [0.1, 0.5, 0.7, 0.9],
        //   colors: [
        //     Color(0x80f33e93),
        //     Color(0x80ee7d00),
        //     // Colors(0xffF18E1B),
        //   ],
        // ),
      ),
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
        maxLength: maxLength,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
          hintText: hint,
          labelText: label,
          errorStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.red.withOpacity(0.7), fontSize: 15),
          labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.7),
              ),
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        onSaved: onSave,
      ),
    );
  }
}
