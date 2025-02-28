import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/add_classified.dart';
import 'package:mlmdiary/classified/classified_detail_screen.dart';
import 'package:mlmdiary/classified/classified_detail_notification.dart';
import 'package:mlmdiary/classified/classified_detail_test_screen.dart';
import 'package:mlmdiary/classified/custom/add_comapany_classfied.dart';
import 'package:mlmdiary/database/database.dart';
import 'package:mlmdiary/firstscreen/first_screen.dart';
import 'package:mlmdiary/forgotpassword/enter_new_password.dart';
import 'package:mlmdiary/forgotpassword/enter_otp_screen.dart';
import 'package:mlmdiary/forgotpassword/forgot_password.dart';
import 'package:mlmdiary/home/addblog/add_blog.dart';
import 'package:mlmdiary/home/addnews/add_news.dart';
import 'package:mlmdiary/home/addpost/add_post.dart';
import 'package:mlmdiary/home/notification/notification.dart';
import 'package:mlmdiary/home/notification/notification_setting_screen.dart';
import 'package:mlmdiary/home/home/searchbar_screen.dart';
import 'package:mlmdiary/login/login_screen.dart';
import 'package:mlmdiary/menu/menuscreens/aboutus/about_us.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/account_setting_screen.dart';
import 'package:mlmdiary/menu/menuscreens/advertising/advertising.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_detail_notification.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/blog/my_blog_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog_plus_icon.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog.dart';
import 'package:mlmdiary/menu/menuscreens/blog/mlm_blog.dart';
import 'package:mlmdiary/menu/menuscreens/contactus/contact_us.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/favourite.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/favouritr_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/followers/followers.dart';
import 'package:mlmdiary/home/message/message_detail_screen.dart';
import 'package:mlmdiary/home/message/message_screen.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manage_classified.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manage_classified_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manageclassified_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompaines.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompanies_details_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompany_notification_detail.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/add_question_answer.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/user_question.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/user_question_copy.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/edit_question_answer.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/question_answer.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news_plus_icon.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news.dart';
import 'package:mlmdiary/menu/menuscreens/news/mlm_news.dart';
import 'package:mlmdiary/menu/menuscreens/news/my_news_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_details_notification.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_details_screen.dart';
import 'package:mlmdiary/menu/menuscreens/plan&companyintrest/planandcompanyintrest.dart';
import 'package:mlmdiary/menu/menuscreens/premiumplan/premium_plan.dart';
import 'package:mlmdiary/menu/menuscreens/profile/edit_post.dart';
import 'package:mlmdiary/menu/menuscreens/profile/my_post_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/profile/post_detail_notification.dart';
import 'package:mlmdiary/menu/menuscreens/profile/post_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/managequationanswer.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/profile_screen.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/user_profile_screen.dart';
import 'package:mlmdiary/menu/menuscreens/referandearn/referand_earn.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/tutorial_video.dart';
import 'package:mlmdiary/menu/menuscreens/video/video.dart';
import 'package:mlmdiary/sign_up/signup_1.dart';
import 'package:mlmdiary/sign_up/signup_2.dart';
import 'package:mlmdiary/splash/splash_screen.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/terms.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.otp,
      page: () {
        if (kDebugMode) {
          print('Arguments type: ${Get.arguments.runtimeType}');
          print('Arguments content: ${Get.arguments}');
        }

        final arguments = Get.arguments as Map<String, dynamic>;
        return EnterOTPScreen(
          email: arguments['email'] as String,
          phone: arguments['phone'] as String,
          countrycode: arguments['countrycode'] as String,
          otp: arguments['otp'] as int,
          userId: arguments['userId'] as int,
        );
      },
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const EnterNewPasswordScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: Routes.signUp2,
      page: () => const AddMoreDetails(),
    ),
    GetPage(
      name: Routes.mainscreen,
      page: () => const FirstScreen(),
    ),
    GetPage(
      name: Routes.databasescreen,
      page: () => const DatabaseScreen(),
    ),
    GetPage(
      name: Routes.addclassified,
      page: () => const AddClassified(),
    ),
    GetPage(
      name: Routes.manageClassifiedplusicon,
      page: () {
        final int classifiedId = Get.arguments;
        return ManageClassifiedPlusIcon(classfiedId: classifiedId);
      },
    ),
    GetPage(
      name: Routes.manageclasifieddetailscreen,
      page: () => ManageClassifiedDetailsScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.mlmclassifieddetail,
      page: () => ClassidiedDetailsScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.mlmclassifieddetailcopy,
      page: () => ClassifiedDetailNotification(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.messagescreen,
      page: () => const Message(),
    ),
    GetPage(
      name: Routes.messagedetailscreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>;

        final String chatId = arguments['chatId'] ?? '';
        final int toId = int.tryParse(arguments['toId'].toString()) ?? 0;
        final String userName = arguments['userName'] ?? '';
        final String userImage = arguments['userImage'] ?? '';

        return MessageDetailsScreen(
          chatId: chatId,
          toId: toId,
          userName: userName,
          userImage: userImage,
        );
      },
    ),
    GetPage(
      name: Routes.aboutus,
      page: () => const AboutUs(),
    ),
    GetPage(
      name: Routes.contactus,
      page: () => const ContactUs(),
    ),
    GetPage(
      name: Routes.terms,
      page: () => const Terms(),
    ),
    GetPage(
      name: Routes.followers,
      page: () => const Followers(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: Routes.notificatiosetting,
      page: () => const Notificationsetting(),
    ),
    GetPage(
      name: Routes.mlmcompanies,
      page: () => const MlmCompanies(),
    ),
    GetPage(
      name: Routes.mlmcompaniesdetails,
      page: () => const MlmCompaniesDetails(),
    ),
    GetPage(
      name: Routes.mlmcompaniesnotificationdetails,
      page: () => const MlmcompanyNotificationDetail(),
    ),
    GetPage(
      name: Routes.userprofilescreen,
      page: () => const UserProfileScreen(),
    ),
    GetPage(
      name: Routes.profilescreen,
      page: () {
        final int userId = Get.arguments;
        return ProfileScreen(userId: userId);
      },
    ),
    GetPage(
      name: Routes.accountsettingscreen,
      page: () => const AccountSetting(),
    ),
    GetPage(
      name: Routes.mlmclassified,
      page: () => const ManageClassified(),
    ),
    GetPage(
      name: Routes.managequationanswer,
      page: () => const ManageQuationAnswer(),
    ),
    GetPage(
      name: Routes.quationanswer,
      page: () => const QuationAnswer(),
    ),
    GetPage(
      name: Routes.question,
      page: () => const Question(),
    ),
    GetPage(
      name: Routes.editquestion,
      page: () => const EditQuestionAnswer(),
    ),
    GetPage(
      name: Routes.favourite,
      page: () => const Favourite(),
    ),
    GetPage(
      name: Routes.managenews,
      page: () => const ManageNews(),
    ),
    GetPage(
      name: Routes.mlmnews,
      page: () => const MlmNews(),
    ),
    GetPage(
      name: Routes.newsplusicon,
      page: () {
        final int newsId = Get.arguments;
        return ManageNewsPlusIcon(newsId: newsId);
      },
    ),
    GetPage(
      name: Routes.addnews,
      page: () => const AddNews(),
    ),
    GetPage(
      name: Routes.mynewsdetails,
      page: () => MyNewsDetailScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.newsdetails,
      page: () => NewsDetailScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.newsdetailsnotification,
      page: () {
        final int newsId = Get.arguments;
        return NewsDetailsNotification(newsId: newsId);
      },
    ),
    GetPage(
      name: Routes.manageblog,
      page: () => const ManageBlog(),
    ),
    GetPage(
      name: Routes.mlmblog,
      page: () => const MlmBlog(),
    ),
    GetPage(
      name: Routes.blogplusicon,
      page: () {
        final int blogId = Get.arguments;
        return ManageBlogPlusIcon(blogId: blogId);
      },
    ),
    GetPage(
      name: Routes.mlmclassifieddetailtest,
      page: () {
        final int classifiedId = Get.arguments;
        return ClassifiedDetailTestScreen(classifiedId: classifiedId);
      },
    ),
    GetPage(
      name: Routes.addblog,
      page: () => const AddBlog(),
    ),
    GetPage(
      name: Routes.myblogdetails,
      page: () => MyBlogDetailScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.blogdetails,
      page: () => BlogDetailScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.blogdetailsnotification,
      page: () {
        final int blogId = Get.arguments;
        return BlogDetailNotification(blogId: blogId);
      },
    ),
    GetPage(
      name: Routes.advertising,
      page: () => const Advertising(),
    ),
    GetPage(
      name: Routes.video,
      page: () => const Video(),
    ),
    GetPage(
      name: Routes.tutorialvideo,
      page: () => const TutorialVideo(),
    ),
    GetPage(
      name: Routes.planandcompanyinterest,
      page: () => const PlanandCompany(),
    ),
    GetPage(
      name: Routes.premiumplan,
      page: () => const PremiumPlan(),
    ),
    GetPage(
      name: Routes.referearn,
      page: () => const ReferEarn(),
    ),
    GetPage(
      name: Routes.addpost,
      page: () => const AddPost(),
    ),
    GetPage(
      name: Routes.editpost,
      page: () {
        final int postId = Get.arguments;
        return EditPost(postId: postId);
      },
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchBarApp(),
    ),
    GetPage(
      name: Routes.addquestionanswer,
      page: () => const AddQuestionAnswer(),
    ),
    GetPage(
      name: Routes.userquestion,
      page: () => const UserQuestion(),
    ),
    GetPage(
      name: Routes.userquestioncopy,
      page: () => const UserQuestionCopy(),
    ),
    GetPage(
      name: Routes.favouritrdetailsscreen,
      page: () => FavouritrDetailScreen(
        key: UniqueKey(),
      ),
    ),
    GetPage(
      name: Routes.addcompanyclassified,
      page: () => const AddCompanyClassified(),
    ),
    GetPage(
      name: Routes.postdetail,
      page: () => const PostDetailScreen(),
    ),
    GetPage(
      name: Routes.postdetailnotification,
      page: () {
        final int postId = Get.arguments;
        return PostDetailNotification(postId: postId);
      },
    ),
    GetPage(
      name: Routes.mypostdetails,
      page: () => const MyPostDetailScreen(),
    ),
  ];
}
