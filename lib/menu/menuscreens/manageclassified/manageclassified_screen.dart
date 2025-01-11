import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/controller/manage_classified_controller.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manageclassified_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_classified.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';

class ManageClassified extends StatefulWidget {
  const ManageClassified({super.key});

  @override
  State<ManageClassified> createState() => _MlmClassifiedState();
}

class _MlmClassifiedState extends State<ManageClassified> {
  final ManageClasifiedController controller =
      Get.put(ManageClasifiedController());

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void deletePost(int index) async {
    int classifiedId = controller.classifiedList[index].id ?? 0;
    await controller.deleteClassified(classifiedId, index, context);
  }

  Future<void> _refreshData() async {
    await controller.fetchClassifieds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Classified',
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          color: AppColors.background,
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.classifiedList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const CustomShimmerClassified(
                        width: 175, height: 240);
                  },
                ),
              );
            }

            if (controller.classifiedList.isEmpty) {
              return Center(
                child: Text(
                  controller.isLoading.value ? 'Loading...' : 'Data not found',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.classifiedList.length,
              itemBuilder: (context, index) {
                final post = controller.classifiedList[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.manageclasifieddetailscreen,
                        arguments: controller.classifiedList[index],
                      );
                    },
                    child: ManageClassifiedCard(
                      onDelete: () => deletePost(index),
                      userImage: post.imagePath ?? '',
                      userName: post.creatby.toString(),
                      postTitle: post.title ?? '',
                      dateTime: post.datecreated ?? '',
                      postCaption: post.description ?? '',
                      postTime: post.datecreated ?? '',
                      updatedateTime: post.datemodified ?? '',
                      controller: controller,
                      viewcounts: post.pgcnt ?? 0,
                      likedCount: post.totallike ?? 0,
                      classifiedId: post.id ?? 0,
                      commentcount: post.totalcomment ?? 0,
                      likedbyuser: post.likedByUser ?? false,
                      bookmarkedbyuser: post.bookmarkedByUser ?? false,
                      isPopular: post.popular == 'Y',
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          var controller = CustomFloatingActionButtonController(context);

          String selectedType = 'classified';

          await controller.handleTap(selectedType);
        },
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              Assets.svgPlusIcon,
            ),
          ),
        ),
      ),
    );
  }
}
