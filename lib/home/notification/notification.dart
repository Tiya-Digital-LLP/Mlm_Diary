import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/home/notification/custom/admin_notification.dart';
import 'package:mlmdiary/home/notification/custom/all_notification.dart';
import 'package:mlmdiary/home/notification/custom/user_notification.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationController controller = Get.put(NotificationController());

  RxInt tabIndex = 0.obs;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    _refreshData();
  }

  void _handleTabSelection() {
    tabIndex.value = _tabController.index;
    _refreshData();
  }

  Future<void> _refreshData() async {
    String type;
    switch (_tabController.index) {
      case 1:
        type = 'user';
        break;
      case 2:
        type = 'admin';
        break;
      default:
        type = 'all';
    }
    await controller.fetchNotification(1, type);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Notifications',
          softWrap: false,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.048,
            color: Colors.black,
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.notificatiosetting);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Assets.svgSetting,
                width: 31,
                height: 31,
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      onTap: (value) {},
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: AppColors.primaryColor,
                      ),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'All',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'User',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Admin',
                            style: textStyleW400(
                              size.width * 0.032,
                              AppColors.blackText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ignore: unrelated_type_equality_checks
                  tabIndex.value != 2
                      ? Container(
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 15, left: 15),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Mark all as read',
                              style: textStyleW700(
                                size.width * 0.035,
                                AppColors.primaryColor,
                              ),
                            ),
                          ))
                      : const SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  RefreshIndicator(
                    backgroundColor: AppColors.primaryColor,
                    color: AppColors.white,
                    onRefresh: _refreshData,
                    child: const SizedBox(
                      child: Center(child: AllNotification()),
                    ),
                  ),
                  RefreshIndicator(
                    backgroundColor: AppColors.primaryColor,
                    color: AppColors.white,
                    onRefresh: _refreshData,
                    child: const SizedBox(
                      child: Center(child: UserNotification()),
                    ),
                  ),
                  RefreshIndicator(
                    backgroundColor: AppColors.primaryColor,
                    color: AppColors.white,
                    onRefresh: _refreshData,
                    child: const SizedBox(
                      child: Center(child: AdminNotification()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
