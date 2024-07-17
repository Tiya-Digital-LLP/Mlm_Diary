import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/sign_up/controller/signup_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/company_border_textfield.dart';
import 'package:mlmdiary/widgets/custom_border_container.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomSheetContent> {
  final DatabaseController controller = Get.put(DatabaseController());
  final _loc = TextEditingController();
  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";
  late double lat = 0.0;
  late double log = 0.0;
  final RxList<String> selectedCompanies = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey.withOpacity(0.5),
              ),
            ),
            5.sbh,
            Center(
              child: Text(
                'Filter',
                style: textStyleW700(size.width * 0.043, AppColors.blackText),
              ),
            ),
            10.sbh,
            Obx(
              () => BorderContainer(
                isError:
                    controller.accountSeetingController.planTypeError.value,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: controller.accountSeetingController
                        .getSelectedPlanOptionsTextController(),
                    readOnly: true,
                    onTap: () {
                      showBottomSheetFuncPlan(
                        context,
                        size,
                        controller.accountSeetingController,
                        controller.accountSeetingController.planList,
                      );
                      controller.accountSeetingController
                          .planCategoryValidation();
                    },
                    style:
                        textStyleW500(size.width * 0.04, AppColors.blackText),
                    cursorColor: AppColors.blackText,
                    decoration: InputDecoration(
                        hintText: "Select Plan Name",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.blackText,
                        )),
                  ),
                ),
              ),
            ),
            10.sbh,
            Obx(
              () => CompanyBorderTextfield(
                height: 65,
                keyboard: TextInputType.multiline,
                textInputType: const [],
                hint: "Company Name",
                readOnly: controller.clasifiedController.companyNameOnly.value,
                controller: controller.clasifiedController.companyName.value,
                isError: controller.clasifiedController.companyError.value,
                byDefault:
                    !controller.clasifiedController.isCompanyNameTyping.value,
                onChanged: (value) {
                  controller.clasifiedController
                      .fetchCompanyNames(value.toString());
                },
                onTap: () async {
                  final result = await Get.to(() => AddCompanyClassified(
                        selectedCompanies: selectedCompanies,
                      ));
                  if (result != null && result is List<String>) {
                    selectedCompanies.clear();
                    selectedCompanies.addAll(result);
                    controller.clasifiedController.companyName.value.text =
                        selectedCompanies.join(", ");
                  }
                },
              ),
            ),
            10.sbh,
            Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: AppColors.white,
                    border: Border.all(
                      color: Colors.grey, // Adjust border color as needed
                      width: 1.0, // Adjust border width as needed
                    ),
                  ),
                  height: 65,
                  child: TextFormField(
                    controller: controller.clasifiedController.location.value,
                    readOnly: true,
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                    ),
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.fullscreen,
                        hint: 'Search and Save Location.',
                        cursorColor: AppColors.primaryColor,
                        types: ['geocode', 'establishment'],
                        strictbounds: false,
                        onError: (err) {},
                      );

                      if (place != null) {
                        setState(() {
                          controller.clasifiedController.location.value.text =
                              place.description.toString();
                          _loc.text = controller
                              .clasifiedController.location.value.text;
                          controller.getMlmDatabase(1);
                        });

                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        for (var component in detail.result.addressComponents) {
                          for (var type in component.types) {
                            if (type == "administrative_area_level_1") {
                              controller.clasifiedController.state.value.text =
                                  component.longName;
                            } else if (type == "locality") {
                              controller.clasifiedController.city.value.text =
                                  component.longName;
                            } else if (type == "country") {
                              controller.clasifiedController.country.value
                                  .text = component.longName;
                            }
                          }
                        }

                        final geometry = detail.result.geometry!;
                        setState(() {
                          lat = geometry.location.lat;
                          log = geometry.location.lng;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search Location",
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackText.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        Fluttertoast.showToast(
                          timeInSecForIosWeb: 2,
                          msg: 'Please Search and Save your Business Location',
                        );
                      } else if (value.isNotEmpty) {
                        // Handle submission if needed
                      }
                    },
                  ),
                )),
            10.sbh,
            Obx(
              () => BorderContainer(
                isError: controller.signupController.mlmTypeError.value,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.signupController
                        .getSelectedOptionsTextController(),
                    readOnly: true,
                    onTap: () async {
                      // ignore: use_build_context_synchronously
                      showBottomSheetFunc(
                          context,
                          size,
                          controller.signupController,
                          controller.signupController.userTypes);
                      controller.signupController.mlmCategoryValidation();
                    },
                    style:
                        textStyleW500(size.width * 0.04, AppColors.blackText),
                    cursorColor: AppColors.blackText,
                    decoration: InputDecoration(
                      hintText: "User Type",
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.clearFields();
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          side: BorderSide(color: AppColors.redText),
                        ),
                        child: Text(
                          'Cancel',
                          style: textStyleW700(
                              size.width * 0.04, AppColors.redText),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.getMlmDatabase(1);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: Text(
                          'Apply',
                          style:
                              textStyleW700(size.width * 0.04, AppColors.white),
                        ),
                      ),
                    ),
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

void showBottomSheetFuncPlan(
  BuildContext context,
  Size size,
  AccountSeetingController controller,
  List<GetPlanListPlan> planList,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey,
                  ),
                  width: 80,
                  height: 5,
                ),
              ),
              5.sbh,
              Center(
                child: Text(
                  'Select Plan',
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
                ),
              ),
              20.sbh,
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: planList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.togglePlanSelected(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      controller.togglePlanSelected(index);
                                    },
                                    child: Image.asset(
                                      (controller.isPlanSelectedList[index])
                                          ? Assets.imagesTrueCircle
                                          : Assets.imagesCircle,
                                    ),
                                  ),
                                ),
                                15.sbw,
                                Text(
                                  planList[index].name ?? '',
                                  style: textStyleW500(
                                      size.width * 0.041, AppColors.blackText),
                                ),
                              ],
                            ),
                          ),
                        ),
                        20.sbh,
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: CustomButton(
                  title: "Continue",
                  btnColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    if (controller.selectedCountPlan > 0) {
                      Get.back();
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select at least one field.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  isLoading: controller.isLoading,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showBottomSheetFunc(
  BuildContext context,
  size,
  SignupController controller,
  List<GetUserTypeUsertype> userTypes,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey,
                  ),
                  width: 80,
                  height: 5,
                ),
              ),
              5.sbh,
              Center(
                child: Text(
                  'I am a MLM*',
                  style: textStyleW600(size.width * 0.045, AppColors.blackText),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: userTypes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toggleSelected(index, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.toggleSelected(index, context);
                                  },
                                  child: Image.asset(
                                    controller.isTypeSelectedList[index]
                                        ? Assets.imagesTrueCircle
                                        : Assets.imagesCircle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                userTypes[index].name ?? '',
                                style: textStyleW500(
                                    size.width * 0.041, AppColors.blackText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
              const SizedBox(height: 100),
              Center(
                child: CustomButton(
                  title: "Continue",
                  btnColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    if (controller.selectedCount > 0) {
                      Get.back();
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select at least one field.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  isLoading: controller.isLoading,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
