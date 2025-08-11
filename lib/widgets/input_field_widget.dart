import 'package:beggining/factory/color_factory.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final Color backgroundColor;
  final String hintText;
  final TextEditingController controller;
  final bool isPass;
  const InputFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPass = false,
    required this.backgroundColor,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _Obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: ColorFactory.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: ColorFactory.textSecondary,
                ),
              ),
              controller: widget.controller,
              //just for debugging
              onChanged: (value) => debugPrint('Input value: $value'),
              obscureText: widget.isPass ? _Obsecure : !_Obsecure,
            ),
          ),
          // const SizedBox(width: 10),
          if (widget.isPass)
            IconButton(
              onPressed: () {
                setState(() {
                  _Obsecure = !_Obsecure;
                });
              },
              icon: Icon(
                _Obsecure ? Icons.visibility_off : Icons.visibility,
                color: ColorFactory.black,
              ),
            )
        ],
      ),
    );
  }
}
