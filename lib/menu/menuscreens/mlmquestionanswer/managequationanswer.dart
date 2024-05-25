import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/manage_quation_answer_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class ManageQuationAnswer extends StatefulWidget {
  const ManageQuationAnswer({super.key});

  @override
  State<ManageQuationAnswer> createState() => _ManageQuationAnswerState();
}

class _ManageQuationAnswerState extends State<ManageQuationAnswer> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Question Answer',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchInput(
                      controller: _search,
                      onSubmitted: (value) {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();

                        setState(() {});
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          WidgetsBinding.instance.focusManager.primaryFocus;

                          setState(() {});
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
            ),
            Container(
              color: AppColors.background,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: manageQuationAnswerList.length,
                itemBuilder: (context, index) {
                  final post = manageQuationAnswerList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.question, arguments: post);
                      },
                      child: ManageQuationCard(
                        userImage: post.userImage,
                        userName: post.userName,
                        postCaption: post.postCaption,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
