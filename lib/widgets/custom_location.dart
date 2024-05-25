import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class CustomLocationInput extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final String? hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool readOnly;
  final TextEditingController controller;
  final double borderRadius;

  const CustomLocationInput({
    super.key,
    this.onChanged,
    this.onClear,
    this.onTap,
    this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.readOnly = true,
    required this.controller,
    this.borderRadius = 12.0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomLocationInputState createState() => _CustomLocationInputState();
}

class _CustomLocationInputState extends State<CustomLocationInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: Colors.white,
      ),
      height: 40,
      margin: const EdgeInsets.only(left: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: TextField(
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: TextStyle(color: AppColors.blackText, fontSize: 14),
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: -4),
            prefixIconConstraints: const BoxConstraints(minWidth: 24),
            suffixIconConstraints: const BoxConstraints(minWidth: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 2, left: 2),
              child: Icon(
                widget.prefixIcon,
                color: AppColors.blackText,
                size: 20,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: widget.onClear,
              child: Padding(
                padding: const EdgeInsets.only(right: 2, left: 2),
                child: Icon(
                  widget.suffixIcon,
                  color: AppColors.blackText,
                  size: 20,
                ),
              ),
            ),
            hintText: widget.hintText ?? 'Location',
            hintStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.blackText,
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
