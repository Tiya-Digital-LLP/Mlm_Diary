import 'package:flutter/material.dart';
import 'package:flutter_autocomplete_label/autocomplete_label.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/company_border_textfield.dart';

class AddComapanyClassfied extends StatefulWidget {
  const AddComapanyClassfied({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddCompanyClassifiedState createState() => _AddCompanyClassifiedState();
}

class _AddCompanyClassifiedState extends State<AddComapanyClassfied> {
  final ClasifiedController controller = Get.put(ClasifiedController());

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
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AutocompleteLabel<String>(
                    onChanged: (value) {
                      controller.fetchCompanyNames(value.toString());
                    },
                    autocompleteLabelController:
                        AutocompleteLabelController<String>(),
                    textEditingController: controller.companyName.value,
                  ),
                  20.sbh,
                  CompanyBorderTextfield(
                    height: 65,
                    keyboard: TextInputType.multiline,
                    textInputType: const [],
                    hint: "Company Name",
                    readOnly: controller.companyNameOnly.value,
                    controller: controller.companyName.value,
                    isError: controller.companyError.value,
                    byDefault: !controller.isCompanyNameTyping.value,
                    onChanged: (value) {
                      controller.fetchCompanyNames(value.toString());
                    },
                    onTap: () {
                      Get.toNamed(Routes.addcompanyclassified);
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
                    return ListTile(
                      title: Text(controller.companyNames[index]),
                      onTap: () {
                        controller.companyName.value.text =
                            controller.companyNames[index];
                      },
                    );
                  },
                  childCount: controller.companyNames.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SvgPicture.asset(Assets.svgPlusIcon),
    );
  }
}
