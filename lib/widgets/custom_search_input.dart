import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

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
    final Size size = MediaQuery.of(context).size;

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
          style: textStyleW600(
            size.width * 0.035,
            AppColors.blackText,
          ),
          controller: controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: -5),
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
            hintStyle: textStyleW600(
              size.width * 0.035,
              AppColors.blackText,
            ),
          ),
          onSubmitted: onSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
