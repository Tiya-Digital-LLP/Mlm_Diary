import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/blog_faviourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/classified_faviourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/company_favourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/database_favourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/news_faviourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/question_favourite_card.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/custom/video_faviouritr_card.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/video/controller/video_controller.dart';
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
  final VideoController videoController = Get.put(VideoController());
  final EditPostController editPostController = Get.put(EditPostController());
  final CompanyController companyController = Get.put(CompanyController());
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());
  final DatabaseController databaseController = Get.put(DatabaseController());

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    try {
      controller.isEndOfData.value = false;
      controller.favouriteList.clear();
      await controller.fetchBookmark(1);
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
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: horiztallist(),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value &&
                  controller.favouriteList.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.favouriteList.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      controller.isLoading.value
                          ? 'Loading...'
                          : 'Data not found',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == controller.favouriteList.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final post = controller.favouriteList[index];
                    Widget cardWidget;
                    switch (post.type) {
                      case 'classified':
                        cardWidget = ClassifiedFavouriteCard(
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
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                          likedbyuser: post.likedByUser ?? false,
                        );
                        break;
                      case 'company':
                        cardWidget = CompanieFaviouriteCard(
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
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                          likedbyuser: post.likedByUser ?? false,
                        );
                        break;

                      case 'blog':
                        cardWidget = BlogFaviouriteCard(
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
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                          likedbyuser: post.likedByUser ?? false,
                        );
                        break;
                      case 'news':
                        cardWidget = NewsFaviouriteCard(
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
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                          likedbyuser: post.likedByUser ?? false,
                        );
                        break;

                      case 'video':
                        cardWidget = VideoFavouriteCard(
                          userImage: post.userData?.imagePath ?? '',
                          userName: post.userData?.name ?? '',
                          postTitle: post.title ?? '',
                          postCaption: post.description ?? '',
                          postVideo: post.image ?? '',
                          dateTime: post.bookmarkDate ?? '',
                          viewcounts: post.pgcnt ?? 0,
                          controller: controller,
                          bookmarkId: post.id ?? 0,
                          url: post.urlcomponent ?? '',
                          type: post.type ?? '',
                        );
                        break;
                      case 'database':
                        cardWidget = DatabaseFavouriteCard(
                          userImage: post.userData?.imagePath ?? '',
                          userName: post.title ?? '',
                          postTitle: post.title ?? '',
                          postLocation: post.city ?? '',
                          immlm: post.immlm ?? '',
                          plan: post.plan ?? '',
                          postImage: post.imageUrl ?? '',
                          dateTime: post.bookmarkDate ?? '',
                          controller: controller,
                          bookmarkId: post.id ?? 0,
                          type: post.type ?? '',
                          manageBlogController: manageBlogController,
                          manageNewsController: manageNewsController,
                          clasifiedController: clasifiedController,
                          companyController: companyController,
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                        );
                        break;
                      case 'question':
                        cardWidget = QuestionFavouriteCard(
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
                          editpostController: editPostController,
                          questionAnswerController: questionAnswerController,
                          likedbyuser: post.likedByUser ?? false,
                        );
                        break;

                      default:
                        cardWidget = const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        left: 16,
                        right: 16,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _navigateToDetails(post);
                        },
                        child: cardWidget,
                      ),
                    );
                  },
                  childCount: controller.favouriteList.length +
                      (controller.isLoading.value ? 1 : 0),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToDetails(post) async {
    switch (post.type) {
      case 'classified':
        if (kDebugMode) {
          print('classified');
        }
        await clasifiedController.fetchClassifiedDetail(post.id ?? 0, context);

        Get.toNamed(Routes.mlmclassifieddetail, arguments: post);
        break;
      case 'company':
        if (kDebugMode) {
          print('company');
        }
        Get.toNamed(Routes.mlmcompaniesdetails, arguments: post);
        break;
      case 'blog':
        if (kDebugMode) {
          print('blog');
        }
        Get.toNamed(Routes.blogdetails, arguments: post);
        break;
      case 'news':
        if (kDebugMode) {
          print('news');
        }
        Get.toNamed(Routes.newsdetails, arguments: post);
        break;
      case 'video':
        if (kDebugMode) {
          print('video');
        }
        break;
      case 'database':
        if (kDebugMode) {
          print('database');
        }
        Get.toNamed(
          Routes.userprofilescreen,
          arguments: post,
        );
        break;
      case 'question':
        if (kDebugMode) {
          print('question');
        }
        await questionAnswerController.getAnswers(
          1,
          post.id ?? 0,
        );
        Get.toNamed(Routes.userquestion, arguments: post);
        break;
      default:
        Get.toNamed(Routes.favouritrdetailsscreen, arguments: post);
        break;
    }
  }

  Widget horiztallist() {
    return SizedBox(
      height: 50,
      child: Obx(() {
        if (controller.isLoading.value && controller.favouriteList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favouriteList.isEmpty) {
          return const Center(
            child: Text(
              'Data not found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }

        return ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.types.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    ChoiceChip(
                      label: Text(
                        controller.types[index],
                      ),
                      selected: controller.selectedType.value ==
                          controller.types[index],
                      selectedColor: AppColors.blackText,
                      onSelected: (bool selected) {
                        controller.selectedType.value =
                            selected ? controller.types[index] : 'All';
                        controller.fetchBookmark(1);
                      },
                      backgroundColor: AppColors.grey.withOpacity(0.3),
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackText,
                              fontFamily: 'assets/fonst/Metropolis-Black.otf')
                          .copyWith(
                              color: controller.selectedType.value ==
                                      controller.types[index]
                                  ? Colors.white
                                  : Colors.black),
                      showCheckmark: false,
                      // checkmarkColor: AppColors.backgroundColor,
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
