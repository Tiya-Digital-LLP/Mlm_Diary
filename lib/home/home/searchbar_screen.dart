import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/home/controller/searchbar_controller.dart';
import 'package:mlmdiary/home/home/custom/blog_home_card.dart';
import 'package:mlmdiary/home/home/custom/classified_home_card.dart';
import 'package:mlmdiary/home/home/custom/company_home_card.dart';
import 'package:mlmdiary/home/home/custom/database_home_card.dart';
import 'package:mlmdiary/home/home/custom/news_home_card.dart';
import 'package:mlmdiary/home/home/custom/post_home_card.dart';
import 'package:mlmdiary/home/home/custom/question_home_card.dart';
import 'package:mlmdiary/home/home/custom/video_home_card.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/video/controller/video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/first_word_capital.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_classified.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

import '../../menu/menuscreens/profile/controller/edit_post_controller.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final HomeController controller = Get.put(HomeController());
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
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final FavouriteController favouriteController =
      Get.put(FavouriteController());
  final SearchbarController searchbarController =
      Get.put(SearchbarController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    try {
      searchbarController.isEndOfData.value = false;
      searchbarController.homeList.clear();
      await searchbarController.getHome(
        1,
      );
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching bookmark data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                'Search',
                style: textStyleW700(size.width * 0.048, AppColors.blackText),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomSearchInput(
                  controller: searchbarController.search,
                  onSubmitted: (value) {
                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                    _refreshData();
                  },
                  onChanged: (value) {
                    _refreshData();
                  },
                ),
              ),
              10.sbh,
              horiztallist(),
              10.sbh,
              Expanded(
                child: Obx(() {
                  if (searchbarController.isLoading.value &&
                      searchbarController.homeList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const CustomShimmerClassified(
                              width: 175, height: 240);
                        },
                      ),
                    );
                  }
                  if (searchbarController.homeList.isEmpty) {
                    return Center(
                      child: Text(
                        'Data not found',
                        style: textStyleW600(
                          size.width * 0.030,
                          AppColors.blackText,
                          isMetropolis: true,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchbarController.homeList.length +
                        (searchbarController.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == searchbarController.homeList.length) {
                        return Center(
                            child: CustomLottieAnimation(
                          child: Lottie.asset(
                            Assets.lottieLottie,
                          ),
                        ));
                      }
                      final post = searchbarController.homeList[index];
                      String location =
                          '${post.city ?? ''}, ${post.state ?? ''}, ${post.country ?? ''}'
                              .trim();
                      if (location == ', ,') {
                        location = 'N/A';
                      }
                      String? plan =
                          post.plan?.isNotEmpty == true ? post.plan : 'N/A';
                      Widget cardWidget;
                      switch (post.type) {
                        case 'classified':
                          cardWidget = ClassifiedHomeCard(
                            updatedateTime: post.datemodified ?? '',
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likecount: post.totallike ?? 0,
                            classifiedId: post.id ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                            isPopular: post.popular == 'Y',
                          );
                          break;
                        case 'company':
                          cardWidget = CompanyHomeCard(
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likedCount: post.totallike ?? 0,
                            companyId: post.id ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                          );
                          break;
                        case 'blog':
                          cardWidget = BlogHomeCard(
                            updatedateTime: post.datemodified ?? '',
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likedCount: post.totallike ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                          );
                          break;
                        case 'news':
                          cardWidget = NewsHomeCard(
                            updatedateTime: post.datemodified ?? '',
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? 'N/A',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likedCount: post.totallike ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                          );
                          break;
                        case 'video':
                          cardWidget = VideoHomeCard(
                            postTitle: post.title ?? '',
                            postVideo: post.image ?? '',
                            videoController: videoController,
                            controller: favouriteController,
                          );
                          break;
                        case 'database':
                          cardWidget = DatabaseHomeCard(
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.title ?? '',
                            postTitle: post.title ?? '',
                            postLocation: location,
                            immlm: post.immlm ?? '',
                            plan: plan.toString(),
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                          );
                          break;
                        case 'question':
                          cardWidget = QuestionHomeCard(
                            updatedateTime: post.datemodified ?? '',
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likedCount: post.totallike ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                          );
                          break;
                        case 'post':
                          cardWidget = PostHomeCard(
                            updatedateTime: post.datemodified ?? '',
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            postCaption: post.description ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            viewcounts: post.pgcnt ?? 0,
                            controller: controller,
                            bookmarkId: post.id ?? 0,
                            url: post.urlcomponent ?? '',
                            type: capitalizeFirstLetter(post.type),
                            manageBlogController: manageBlogController,
                            manageNewsController: manageNewsController,
                            clasifiedController: clasifiedController,
                            companyController: companyController,
                            editpostController: editPostController,
                            questionAnswerController: questionAnswerController,
                            likedbyuser: post.likedByUser ?? false,
                            likecount: post.totallike ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            likedCount: post.totallike ?? 0,
                            bookmarkedbyuser: post.bookmarkByUser ?? false,
                          );
                          break;
                        default:
                          cardWidget = const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            _navigateToDetails(post);
                          },
                          child: cardWidget,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
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
          print('Navigating to UserProfileScreenCopy with post: $post');
          print('database UserId:${post.id}');
        }
        Get.toNamed(Routes.userprofilescreen, arguments: {'user_id': post.id});
        await userProfileController.fetchUserAllPost(1, post.id.toString());
        break;
      case 'question':
        if (kDebugMode) {
          print('question');
        }

        Get.toNamed(Routes.userquestion, arguments: post);
        break;
      case 'post':
        if (kDebugMode) {
          print('post');
        }

        Get.toNamed(Routes.postdetail, arguments: post);
        break;
      default:
        Get.toNamed(Routes.mainscreen, arguments: post);
        break;
    }
  }

  Widget horiztallist() {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: searchbarController.types.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                Obx(
                  () => ChoiceChip(
                    label: Text(
                      searchbarController.types[index],
                    ),
                    selected: searchbarController.selectedType.value ==
                        searchbarController.types[index],
                    selectedColor: AppColors.blackText,
                    onSelected: (bool selected) {
                      searchbarController.selectedType.value =
                          selected ? searchbarController.types[index] : 'All';
                      searchbarController.getHome(
                        1,
                      );
                    },
                    // ignore: deprecated_member_use
                    backgroundColor: AppColors.grey.withOpacity(0.3),
                    side: BorderSide.none,
                    labelStyle: textStyleW600(
                      size.width * 0.035,
                      AppColors.white,
                    ).copyWith(
                      color: searchbarController.selectedType.value ==
                              searchbarController.types[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                    showCheckmark: false,
                    // checkmarkColor: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
