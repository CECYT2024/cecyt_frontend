import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    required this.hint,
    required this.label,
    required this.onSave,
    required this.maxLength,
    required this.controller,
    this.validator,
    super.key,
    this.keyboard = TextInputType.text,
  });
  final String hint;
  final String label;
  final void Function(String? text) onSave;
  final int maxLength;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        obscureText: !_isVisible,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
        keyboardType: widget.keyboard,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            icon: Icon(
              !_isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
          hintText: widget.hint,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.7),
              ),
          counterText: '',
          errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.7),
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        onSaved: widget.onSave,
      ),
    );
  }
}
