import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class CustomSearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Function(String) onChanged;

  const CustomSearchInput({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.white,
      ),
      height: 40,
      margin: const EdgeInsets.only(left: 6.0),
      width: MediaQuery.of(context).size.width / 2.2,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: TextField(
          style: TextStyle(color: AppColors.blackText, fontSize: 14),
          controller: controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIconConstraints: const BoxConstraints(minWidth: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5.0),
              child: Icon(
                Icons.search,
                color: AppColors.blackText,
                size: 20,
              ),
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.blackText,
            ),
          ),
          onSubmitted: onSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
