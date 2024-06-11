import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/favouritr_card.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FavouriteController controller = Get.put(FavouriteController());
  final ManageBlogController manageBlogController =
      Get.put(ManageBlogController());
  final ManageNewsController manageNewsController =
      Get.put(ManageNewsController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final CompanyController companyController = Get.put(CompanyController());

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    try {
      await controller.fetchBookmark(1, context);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching bookmark data: $error');
      }
    }
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
          child: const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Favourite',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          color: AppColors.background,
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.favouriteList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.favouriteList.isEmpty) {
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
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.favouriteList.length +
                    (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.favouriteList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = controller.favouriteList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.favouritrdetailsscreen,
                          arguments: controller.favouriteList[index],
                        );
                      },
                      child: FavouritrCard(
                        userImage: post.userData?.imagePath ?? '',
                        userName: post.userData?.name ?? '',
                        postTitle: post.title ?? '',
                        postCaption: post.description ?? '',
                        postImage: post.imageUrl ?? '',
                        dateTime: post.bookmarkDate ?? '',
                        viewcounts: post.pgcnt ?? 0,
                        controller: controller,
                        bookmarkId: post.id ?? 0,
                        url: post.urlcomponent ?? '',
                        type: post.type ?? '',
                        manageBlogController: manageBlogController,
                        manageNewsController: manageNewsController,
                        clasifiedController: clasifiedController,
                        companyController: companyController,
                      ),
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
