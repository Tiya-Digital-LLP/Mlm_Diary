import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddComapanyClassfied extends StatefulWidget {
  const AddComapanyClassfied({super.key});

  @override
  State<AddComapanyClassfied> createState() => _StringMultilineTagsState();
}

class _StringMultilineTagsState extends State<AddComapanyClassfied> {
  late double _distanceToField;
  late StringTagController _stringTagController;
  final ClasifiedController controller = Get.put(ClasifiedController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
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
                Get.back();
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            TextFieldTags<String>(
              textfieldTagsController: _stringTagController,
              textSeparators: const [' ', ','],
              letterCase: LetterCase.normal,
              validator: (String tag) {
                if (tag == 'php') {
                  return 'No, please just no';
                } else if (_stringTagController.getTags!.contains(tag)) {
                  return 'You\'ve already entered that';
                }
                return null;
              },
              inputFieldBuilder: (context, inputFieldValues) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    cursorColor: AppColors.primaryColor,
                    onTap: () {
                      _stringTagController.getFocusNode?.requestFocus();
                    },
                    controller: controller.companyName.value,
                    focusNode: inputFieldValues.focusNode,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.blackText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.blackText,
                        ),
                      ),
                      helperText: 'Enter company...',
                      helperStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Enter company...",
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.8),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  16,
                                ),
                                child: Wrap(
                                    runSpacing: 4.0,
                                    spacing: 4.0,
                                    children:
                                        inputFieldValues.tags.map((String tag) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          color: AppColors.blackText,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                tag,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              onTap: () {
                                                // print("$tag selected");
                                              },
                                            ),
                                            8.sbw,
                                            InkWell(
                                              child: Icon(
                                                Icons.cancel,
                                                size: 14.0,
                                                color: AppColors.white,
                                              ),
                                              onTap: () {
                                                inputFieldValues
                                                    .onTagRemoved(tag);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      inputFieldValues.onTagChanged(value);
                      controller.fetchCompanyNames(value);
                    },
                    onSubmitted: inputFieldValues.onTagSubmitted,
                  ),
                );
              },
            ),
            10.sbh,
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }
              if (controller.companyNames.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: controller.companyNames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.companyNames[index]),
                          onTap: () {
                            // Update the text field with the selected company name
                            controller.companyName.value.text =
                                controller.companyNames[index];
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
            10.sbh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    _stringTagController.clearTags();
                    controller.companyName.value.clear();
                  },
                  child: const Text(
                    'CLEAR TAGS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    // Add functionality for 'Add TAGS' button if needed
                  },
                  child: const Text(
                    'Add TAGS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
