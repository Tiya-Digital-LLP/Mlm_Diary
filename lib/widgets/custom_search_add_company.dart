import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class CustomSearchAddCompany extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final List<String> suggestions; // New parameter for suggestions

  const CustomSearchAddCompany({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
    required this.suggestions, // Initialize the suggestions parameter
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchInputState createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchAddCompany> {
  bool showSuggestions = false;

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
      child: Stack(
        children: [
          TextField(
            style: TextStyle(color: AppColors.blackText, fontSize: 14),
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: -4),
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
            onSubmitted: widget.onSubmitted,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                showSuggestions = value.isNotEmpty;
              });
            },
          ),
          if (showSuggestions && widget.suggestions.isNotEmpty)
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.suggestions
                      .map((suggestion) => InkWell(
                            onTap: () {
                              widget.controller.text = suggestion;
                              widget.onSubmitted(suggestion);
                              setState(() {
                                showSuggestions = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackText,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
