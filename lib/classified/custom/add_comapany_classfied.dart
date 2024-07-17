import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_search_add_company.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class AddCompanyClassified extends StatefulWidget {
  final List<String>? selectedCompanies;

  const AddCompanyClassified({super.key, this.selectedCompanies});

  @override
  // ignore: library_private_types_in_public_api
  _AddCompanyClassifiedState createState() => _AddCompanyClassifiedState();
}

class _AddCompanyClassifiedState extends State<AddCompanyClassified> {
  final ClasifiedController controller = Get.put(ClasifiedController());

  late RxList<String> selectedCompanies;
  final RxList<String> suggestions = <String>[].obs;

  @override
  void initState() {
    super.initState();
    selectedCompanies = RxList<String>(widget.selectedCompanies ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back(result: selectedCompanies);
              },
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Company Select',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CustomSearchAddCompany(
                    controller: controller.companyName.value,
                    suggestions: suggestions,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        selectedCompanies.add(value);
                        controller.companyName.value.clear();
                      }
                    },
                    onChanged: (value) {
                      controller.fetchCompanyNames(value.toString());
                      updateSuggestions(value);
                    },
                  ),
                  10.sbh,
                ],
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        constraints: BoxConstraints(
                          maxWidth: size.width,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedCompanies[index],
                              style: textStyleW500(
                                size.width * 0.03,
                                AppColors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            10.sbw,
                            InkWell(
                              onTap: () {
                                selectedCompanies.removeAt(index);
                              },
                              child:
                                  const Icon(Icons.close, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: selectedCompanies.length,
                ),
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.companyName.value.text =
                              controller.companyNames[index];
                          selectedCompanies.add(controller.companyNames[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildHighlightedText(
                            controller.companyNames[index],
                            controller.companyName.value.text,
                            size.width * 0.03,
                            AppColors.blackText.withOpacity(0.6),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: controller.companyNames.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NormalButton(
            onPressed: () {
              controller.companyName.value.clear();

              Get.back(result: selectedCompanies);
            },
            text: 'Submit',
            isLoading: controller.isLoading,
          ),
        ),
      ),
    );
  }

  Widget buildHighlightedText(
    String text,
    String highlight,
    double fontSize,
    Color color,
  ) {
    if (highlight.isEmpty) {
      return Text(
        text,
        style: textStyleW500(fontSize, color),
      );
    }

    final RegExp regex = RegExp(
      highlight,
      caseSensitive: false,
    );

    final Iterable<Match> matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: textStyleW500(fontSize, color),
      );
    }

    int start = 0;
    final List<TextSpan> spans = [];

    for (final Match match in matches) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: textStyleW500(fontSize, color),
          ),
        );
      }

      final String matchText = text.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: matchText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.blackText,
          ),
        ),
      );

      start = match.end;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: textStyleW500(fontSize, color),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  void updateSuggestions(String value) {
    if (value.isEmpty) {
      suggestions.clear();
      return;
    }

    suggestions.assignAll(controller.companyNames.where(
      (company) => company.toLowerCase().contains(value.toLowerCase()),
    ));
  }
}
