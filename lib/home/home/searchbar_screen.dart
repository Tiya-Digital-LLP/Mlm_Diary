import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/home/custom/blog_home_card.dart';
import 'package:mlmdiary/home/home/custom/classified_home_card.dart';
import 'package:mlmdiary/home/home/custom/company_home_card.dart';
import 'package:mlmdiary/home/home/custom/database_home_card.dart';
import 'package:mlmdiary/home/home/custom/news_home_card.dart';
import 'package:mlmdiary/home/home/custom/post_home_card.dart';
import 'package:mlmdiary/home/home/custom/question_home_card.dart';
import 'package:mlmdiary/home/home/custom/video_home_card.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/video/controller/video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    try {
      controller.isEndOfData.value = false;
      controller.homeList.clear();
      await controller.getHome(1);
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
                  controller: controller.search,
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
                  if (controller.isLoading.value &&
                      controller.homeList.isEmpty) {
                    return Center(
                        child: CustomLottieAnimation(
                      child: Lottie.asset(
                        Assets.lottieLottie,
                      ),
                    ));
                  }
                  if (controller.homeList.isEmpty) {
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
                    shrinkWrap: true,
                    itemCount: controller.homeList.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.homeList.length) {
                        return Center(
                            child: CustomLottieAnimation(
                          child: Lottie.asset(
                            Assets.lottieLottie,
                          ),
                        ));
                      }
                      final post = controller.homeList[index];
                      Widget cardWidget;
                      switch (post.type) {
                        case 'classified':
                          cardWidget = ClassifiedHomeCard(
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
                            type: post.type ?? '',
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
                            type: post.type ?? '',
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
                            type: post.type ?? '',
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
                            type: post.type ?? '',
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
                          );
                          break;
                        case 'database':
                          cardWidget = DatabaseHomeCard(
                            userImage: post.userData?.imagePath ?? '',
                            userName: post.title ?? '',
                            postTitle: post.title ?? '',
                            postLocation: post.city ?? '',
                            immlm: post.immlm ?? '',
                            plan: post.plan ?? '',
                            postImage: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
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
                          cardWidget = QuestionHomeCard(
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
                            type: post.type ?? '',
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
                            type: post.type ?? '',
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
    return SizedBox(
      height: 50,
      child: Obx(() {
        if (controller.isLoading.value && controller.homeList.isEmpty) {
          return Center(
              child: CustomLottieAnimation(
            child: Lottie.asset(
              Assets.lottieLottie,
            ),
          ));
        }

        if (controller.homeList.isEmpty) {
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
                        controller.getHome(1);
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
