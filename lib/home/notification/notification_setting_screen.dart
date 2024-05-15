// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class Notificationsetting extends StatefulWidget {
  const Notificationsetting({super.key});

  @override
  State<Notificationsetting> createState() => _NotificationsettingState();
}

class Choice {
  Choice({required this.title, required this.icon});

  String title;
  RxBool icon;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Sell Post', icon: true.obs),
  Choice(title: 'Buy Post', icon: true.obs),
  Choice(title: 'Domestic', icon: true.obs),
  Choice(title: 'International', icon: true.obs),
  Choice(title: 'Category, Type, Grade Match', icon: true.obs),
  Choice(title: 'Followers', icon: true.obs),
  Choice(title: 'Post Interested', icon: true.obs),
  Choice(title: 'Post Comment', icon: true.obs),
  Choice(title: 'Favourite', icon: true.obs),
  Choice(title: 'Business Profile Like', icon: true.obs),
  Choice(title: 'User Follow', icon: true.obs),
  Choice(title: 'User Unfollow', icon: true.obs),
  Choice(title: 'Live Price', icon: true.obs),
  Choice(title: 'Quick News', icon: true.obs),
  Choice(title: 'News', icon: true.obs),
  Choice(title: 'Blog', icon: true.obs),
  Choice(title: 'Video', icon: true.obs),
  Choice(title: 'Banner', icon: true.obs),
  Choice(title: 'Chat', icon: true.obs),
];

class _NotificationsettingState extends State<Notificationsetting> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
            //For Appbar color not change while scroll
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Notification Settings',
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.048,
                color: Colors.black,
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomBackButton(),
            )),
        body: notificationsetting());
  }

  Widget notificationsetting() {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: choices.length,
          padding: const EdgeInsets.fromLTRB(3.0, 0, 3.0, 0),
          itemBuilder: (context, index) {
            Choice record = choices[index];
            return GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 65,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.05),
                      ),
                      shadows: [customBoxShadow()],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SvgPicture.asset(
                            Assets.svgBellIcon,
                            height: 30,
                          ),
                        ),
                        Expanded(
                            child: Text(
                          record.title,
                          style: textStyleW600(
                              size.width * 0.035, AppColors.blackText),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Obx(
                            () => Switch(
                              value: record.icon.value,
                              onChanged: (value) {
                                record.icon.value = value;
                              },
                              activeTrackColor: AppColors.primaryColor,
                              activeColor: Colors.white,
                              inactiveTrackColor: AppColors.grey,
                              inactiveThumbColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
