import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/add_classified.dart';
import 'package:mlmdiary/classified/classified_detail_screen.dart';
import 'package:mlmdiary/firstscreen/first_screen.dart';
import 'package:mlmdiary/forgotpassword/enter_new_password.dart';
import 'package:mlmdiary/forgotpassword/enter_otp_screen.dart';
import 'package:mlmdiary/forgotpassword/forgot_password.dart';
import 'package:mlmdiary/home/addblog/add_blog.dart';
import 'package:mlmdiary/home/addnews/add_news.dart';
import 'package:mlmdiary/home/addpost/add_post.dart';
import 'package:mlmdiary/home/notification/notification.dart';
import 'package:mlmdiary/home/notification/notification_setting_screen.dart';
import 'package:mlmdiary/home/searchbar_screen.dart';
import 'package:mlmdiary/login/login_screen.dart';
import 'package:mlmdiary/menu/menuscreens/aboutus/about_us.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/account_setting_screen.dart';
import 'package:mlmdiary/menu/menuscreens/advertising/advertising.dart';
import 'package:mlmdiary/menu/menuscreens/blog/blog_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/blog/my_blog_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog_plus_icon.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog.dart';
import 'package:mlmdiary/menu/menuscreens/blog/mlm_blog.dart';
import 'package:mlmdiary/menu/menuscreens/contactus/contact_us.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/favourite.dart';
import 'package:mlmdiary/menu/menuscreens/followers/followers.dart';
import 'package:mlmdiary/home/message/message_detail_screen.dart';
import 'package:mlmdiary/home/message/message_screen.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manage_classified.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manage_classified_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/manageclassified_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompaines.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompanies_details_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/add_question_answer.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/user_question.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/custom/question.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/question_answer.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news_plus_icon.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news.dart';
import 'package:mlmdiary/menu/menuscreens/news/mlm_news.dart';
import 'package:mlmdiary/menu/menuscreens/news/my_news_detail_screen.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_details_screen.dart';
import 'package:mlmdiary/menu/menuscreens/plan&companyintrest/planandcompanyintrest.dart';
import 'package:mlmdiary/menu/menuscreens/premiumplan/premium_plan.dart';
import 'package:mlmdiary/menu/menuscreens/profile/edit_post.dart';
import 'package:mlmdiary/menu/menuscreens/profile/profile_screen.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/managequationanswer.dart';
import 'package:mlmdiary/menu/menuscreens/profile/user_profile_screen.dart';
import 'package:mlmdiary/menu/menuscreens/referandearn/referand_earn.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/tutorial_video.dart';
import 'package:mlmdiary/menu/menuscreens/video/video.dart';
import 'package:mlmdiary/sign_up/signup_1.dart';
import 'package:mlmdiary/sign_up/signup_2.dart';
import 'package:mlmdiary/splash/splash_screen.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/advertise_with_us_screen.dart';

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
      page: () => const EnterOTPScreen(),
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
      name: Routes.addclassified,
      page: () => const AddClassified(),
    ),
    GetPage(
      name: Routes.manageClassifiedplusicon,
      page: () => const ManageClassifiedPlusIcon(),
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
      name: Routes.messagescreen,
      page: () => const Message(),
    ),
    GetPage(
      name: Routes.messagedetailscreen,
      page: () => MessageDetailsScreen(
        post: Get.arguments,
      ),
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
      name: Routes.advertisewithus,
      page: () => const AddwertiseWithUs(),
    ),
    GetPage(
      name: Routes.followers,
      page: () => const Folowers(),
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
      name: Routes.profilescreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: Routes.userprofilescreen,
      page: () => const UserProfileScreen(),
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
      page: () => const ManageNewsPlusIcon(),
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
      name: Routes.manageblog,
      page: () => const ManageBlog(),
    ),
    GetPage(
      name: Routes.mlmblog,
      page: () => const MlmBlog(),
    ),
    GetPage(
      name: Routes.blogplusicon,
      page: () => const ManageBlogPlusIcon(),
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
      page: () => const EditPost(),
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
  ];
}
