import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CustomSearchAddCompany extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final List<String> suggestions;

  const CustomSearchAddCompany({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
    required this.suggestions,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchInputState createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchAddCompany> {
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSuffixIcon);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSuffixIcon);
    super.dispose();
  }

  void _updateSuffixIcon() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.white,
      ),
      height: 40,
      width: MediaQuery.of(context).size.width / 2.2,
      child: Stack(
        children: [
          TextField(
            style: textStyleW600(
              size.width * 0.035,
              AppColors.blackText,
            ),
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              prefixIconConstraints: const BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.search,
                  color: AppColors.blackText,
                  size: 20,
                ),
              ),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.add,
                          color: AppColors.primaryColor, size: 20),
                      onPressed: () {
                        widget.onSubmitted(widget.controller.text);
                      },
                    )
                  : null,
              hintText: 'Search',
              hintStyle: textStyleW600(
                size.width * 0.035,
                AppColors.blackText,
              ),
            ),
            onSubmitted: widget.onSubmitted,
            onChanged: (value) {
              String formattedText = value
                  .split(' ')
                  .map((word) => word.isNotEmpty
                      ? word[0].toUpperCase() + word.substring(1)
                      : '')
                  .join(' ');

              if (formattedText != value) {
                widget.controller.value = TextEditingValue(
                  text: formattedText,
                  selection:
                      TextSelection.collapsed(offset: formattedText.length),
                );
              }

              widget.onChanged(formattedText);
              setState(() {
                showSuggestions = formattedText.isNotEmpty;
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
                                style: textStyleW600(
                                  size.width * 0.035,
                                  AppColors.blackText,
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
