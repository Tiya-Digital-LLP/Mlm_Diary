import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompanies_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class MlmCompanies extends StatefulWidget {
  const MlmCompanies({super.key});

  @override
  State<MlmCompanies> createState() => _MlmCompaniesState();
}

class _MlmCompaniesState extends State<MlmCompanies> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Companies',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchInput(
                    controller: _search,
                    onSubmitted: (value) {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        WidgetsBinding.instance.focusManager.primaryFocus;
                      }
                    },
                  ),
                ),
                5.sbw,
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const BottomSheetContent();
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.048,
                    width: size.height * 0.048,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white, shape: BoxShape.circle),
                    child: SvgPicture.asset(Assets.svgFilter),
                  ),
                ),
              ],
            ),
            10.sbh,
            Expanded(
              child: Container(
                color: AppColors.background,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: companyListData.length,
                  itemBuilder: (context, index) {
                    final post = companyListData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.mlmcompaniesdetails,
                              arguments: post);
                        },
                        child: MlmCompaniesCard(
                          userImage: post.userImage,
                          postTitle: post.postTitle,
                          postCaption: post.postCaption,
                          location: post.location,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
