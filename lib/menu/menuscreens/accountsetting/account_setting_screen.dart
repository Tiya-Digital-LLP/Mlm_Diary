import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/custom/custom_login_details_screen.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/custom/custom_social.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/custom/custom_userinfo.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());

  static const String position = 'account_setting';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    videoController.fetchVideo(position, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustonTestAppBar(
          size: MediaQuery.of(context).size,
          titleText: 'Account Settings',
          onTap: () {},
          position: position,
          homeScreenController: homeScreenController,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(42.26),
                          color: AppColors.primaryColor),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'User Info',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Social Media',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Login Details',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    SingleChildScrollView(
                      child: CustomUserinfo(
                        tabContent: 'CustomUserinfo',
                      ),
                    ),
                    SingleChildScrollView(child: CustomSocial()),
                    SingleChildScrollView(child: CustomLoginDetailsScreen()),
                  ]),
            ),
          ],
        ));
  }
}
