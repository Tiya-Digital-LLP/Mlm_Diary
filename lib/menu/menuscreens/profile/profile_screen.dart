import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/post_card.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
              alignment: Alignment.topLeft, child: CustomBackButton()),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Profile',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.imagesIcon,
                                height: 100,
                              ),
                              30.sbw,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aman Talaviya',
                                    style: textStyleW700(size.width * 0.045,
                                        AppColors.blackText),
                                  ),
                                  Text(
                                    'Trainer',
                                    style: textStyleW500(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                  Text(
                                    'Kavya Info Tech Pvt. Ltd.',
                                    style: textStyleW500(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                  Text(
                                    'XYZ Info Tech',
                                    style: textStyleW500(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          20.sbh,
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Follow',
                                            style: textStyleW700(
                                                size.width * 0.030,
                                                AppColors.white),
                                          )),
                                    ),
                                  ),
                                  20.sbw,
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '190',
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Followers',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                      20.sbw,
                                      Column(
                                        children: [
                                          Text(
                                            '190',
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Following',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                      20.sbw,
                                      Column(
                                        children: [
                                          Text(
                                            '190',
                                            style: textStyleW700(
                                                size.width * 0.045,
                                                AppColors.blackText),
                                          ),
                                          Text(
                                            'Profile Visits',
                                            style: textStyleW500(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          20.sbh,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svgCalling,
                                            height: 20,
                                          ),
                                          10.sbw,
                                          Text(
                                            'Call',
                                            style: textStyleW700(
                                                size.width * 0.035,
                                                AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  10.sbw,
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svgChat,
                                            height: 20,
                                          ),
                                          10.sbw,
                                          Text(
                                            'Message',
                                            style: textStyleW700(
                                                size.width * 0.035,
                                                AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  15.sbw,
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.svgWhatsappIcon,
                                              height: 20,
                                            ),
                                            10.sbw,
                                            Text(
                                              'WhatsApp',
                                              style: textStyleW700(
                                                  size.width * 0.035,
                                                  AppColors.primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.sbh,
                  const Divider(
                    color: Colors.black26,
                    height: 2.0,
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    indicatorColor: AppColors.primaryColor,
                    indicatorWeight: 1.5,
                    labelColor: AppColors.primaryColor,
                    tabs: const [
                      Tab(text: 'Posts (22)'),
                      Tab(text: 'About Me'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: AppColors.background,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 1.4,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 16, right: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: postList.length,
                                  itemBuilder: (context, index) {
                                    final post = postList[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: PostCard(
                                        userImage: post.userImage,
                                        userName: post.userName,
                                        postCaption: post.postCaption,
                                        postImage: post.postImage,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow me on',
                                                      style: textStyleW400(
                                                          size.width * 0.035,
                                                          AppColors.grey),
                                                    ),
                                                    15.sbh,
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SvgPicture.asset(Assets
                                                            .svgLogosFacebook),
                                                        12.sbw,
                                                        SvgPicture.asset(Assets
                                                            .svgInstagram),
                                                        12.sbw,
                                                        SvgPicture.asset(Assets
                                                            .svgLogosLinkedinIcon),
                                                        12.sbw,
                                                        SvgPicture.asset(
                                                            Assets.svgYoutube),
                                                        12.sbw,
                                                        SvgPicture.asset(
                                                            Assets.svgTwitter),
                                                        12.sbw,
                                                        SvgPicture.asset(
                                                            Assets.svgTelegram),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.sbh,
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: AppColors.white,
                                              border: const Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey)),
                                            ),
                                          ),
                                          10.sbh,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'About me',
                                                  style: textStyleW400(
                                                      size.width * 0.035,
                                                      AppColors.grey),
                                                ),
                                                Text(
                                                  'Since electricity prices in Europe have reached record highs and all we hear and read about are electricity shortages, everyone is talking about saving electricity. And this applies not only to us but also to manufacturers and users in the plastics processing industry. ',
                                                  style: textStyleW500(
                                                      size.width * 0.035,
                                                      AppColors.blackText),
                                                ),
                                              ],
                                            ),
                                          ),
                                          10.sbh,
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: AppColors.white,
                                              border: const Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey)),
                                            ),
                                          ),
                                          10.sbh,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'About me',
                                                  style: textStyleW400(
                                                      size.width * 0.035,
                                                      AppColors.grey),
                                                ),
                                                Text(
                                                  'Since electricity prices in Europe have reached record highs and all we hear and read about are electricity shortages, everyone is talking about saving electricity. And this applies not only to us but also to manufacturers and users in the plastics processing industry. ',
                                                  style: textStyleW500(
                                                      size.width * 0.035,
                                                      AppColors.blackText),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.017,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
