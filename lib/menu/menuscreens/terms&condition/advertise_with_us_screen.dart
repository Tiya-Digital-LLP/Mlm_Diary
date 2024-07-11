// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class AddwertiseWithUs extends StatefulWidget {
  const AddwertiseWithUs({super.key});

  @override
  State<AddwertiseWithUs> createState() => _AdwithusState();
}

class _AdwithusState extends State<AddwertiseWithUs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TermsController _termsController = Get.put(TermsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'advertisewithus';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _termsController.fetchTermsAndConditions();
    videoController.fetchVideo(position, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustonTestAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Terms and Condition',
        onTap: () {},
        position: position,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(42.26),
                      color: AppColors.primaryColor),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Blog'),
                    Tab(text: 'Classified'),
                    Tab(text: 'News'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.4,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vestibulum sapien mi, quis condimentum neque dapibus sed. Vestibulum quis euismod lacus. Fusce rhoncus erat eget risus dignissim, sit amet lobortis nibh venenatis. Curabitur molestie, lorem et dictum maximus, ante nisl porta libero, non volutpat massa arcu sit amet purus. Nullam eu gravida lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse mollis urna eget lectus tincidunt sollicitudin. Cras efficitur dolor eu metus pretium, nec consectetur nibh luctus. Phasellus fermentum ante sit amet luctus malesuada. Etiam sodales diam id est tempor, eu iaculis tortor consectetur. Aliquam quis ante sed nibh ultricies ornare vitae sed urna. Phasellus vehicula eget dui sit amet dignissim. Nunc ac rhoncus lacus. Nulla facilisi. Suspendisse non augue nisl. Mauris malesuada condimentum risus ac aliquet. Suspendisse quis finibus lacus. Vivamus eu pulvinar mauris. Quisque dignissim, sapien vitae malesuada scelerisque, leo felis feugiat odio, ac dapibus ante sem viverra nisl. Quisque ac dui luctus, eleifend ex nec, porta tortor. Donec fermentum, enim eget convallis aliquet, sem tellus faucibus metus, a dapibus nibh orci a justo. Duis neque leo, sollicitudin sit amet sagittis non, molestie ut orci. Vivamus vulputate tincidunt auctor. Aliquam non arcu id erat congue tincidunt vitae aliquam dui. Mauris dictum lectus quam, a dictum magna auctor quis. Nullam leo lectus, sodales mollis eleifend sit amet, finibus ac metus. Fusce interdum ultricies erat a pellentesque. Sed venenatis quis tellus sit amet placerat. Nullam maximus dictum tristique. Maecenas interdum elementum tellus, eget aliquet magna pulvinar in. Suspendisse ornare erat nibh, nec faucibus nunc laoreet at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pharetra quam eu eros rutrum bibendum. Morbi eget metus eu libero laoreet interdum. Sed justo justo, efficitur rhoncus tempor id, pretium eget est. Suspendisse pharetra dui a nunc blandit congue. Nulla tellus sapien, malesuada non pulvinar eget, fringilla congue dui. Nunc aliquam sodales sodales. Donec ullamcorper dolor urna, in suscipit purus tempor a. Ut sollicitudin fermentum ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vestibulum sapien mi, quis condimentum neque dapibus sed. Vestibulum quis euismod lacus. Fusce rhoncus erat eget risus dignissim, sit amet lobortis nibh venenatis. Curabitur molestie, lorem et dictum maximus, ante nisl porta libero, non volutpat massa arcu sit amet purus. Nullam eu gravida lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse mollis urna eget lectus tincidunt sollicitudin. Cras efficitur dolor eu metus pretium, nec consectetur nibh luctus. Phasellus fermentum ante sit amet luctus malesuada. Etiam sodales diam id est tempor, eu iaculis tortor consectetur. Aliquam quis ante sed nibh ultricies ornare vitae sed urna. Phasellus vehicula eget dui sit amet dignissim. Nunc ac rhoncus lacus. Nulla facilisi. Suspendisse non augue nisl. Mauris malesuada condimentum risus ac aliquet. Suspendisse quis finibus lacus. Vivamus eu pulvinar mauris. Quisque dignissim, sapien vitae malesuada scelerisque, leo felis feugiat odio, ac dapibus ante sem viverra nisl. Quisque ac dui luctus, eleifend ex nec, porta tortor. Donec fermentum, enim eget convallis aliquet, sem tellus faucibus metus, a dapibus nibh orci a justo. '),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Builder(
                      builder: (context) {
                        return Obx(() {
                          if (_termsController.isLoading.value) {
                            return CustomLottieAnimation(
                              child: Lottie.asset(
                                Assets.lottieLottie,
                              ),
                            ); // or any other loading indicator
                          } else if (_termsController
                                  .termsAndConditions.value !=
                              null) {
                            return Html(
                              data: _termsController.termsAndConditions.value
                                  .toString(),
                              style: {
                                "body": Style(
                                  fontSize: FontSize(16.0),
                                  color: Colors.black,
                                ),
                              },
                            );
                          } else {
                            return const Text(
                              'Failed to load terms and conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.red,
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vestibulum sapien mi, quis condimentum neque dapibus sed. Vestibulum quis euismod lacus. Fusce rhoncus erat eget risus dignissim, sit amet lobortis nibh venenatis. Curabitur molestie, lorem et dictum maximus, ante nisl porta libero, non volutpat massa arcu sit amet purus. Nullam eu gravida lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse mollis urna eget lectus tincidunt sollicitudin. Cras efficitur dolor eu metus pretium, nec consectetur nibh luctus. Phasellus fermentum ante sit amet luctus malesuada. Etiam sodales diam id est tempor, eu iaculis tortor consectetur. Aliquam quis ante sed nibh ultricies ornare vitae sed urna. Phasellus vehicula eget dui sit amet dignissim. Nunc ac rhoncus lacus. Nulla facilisi. Suspendisse non augue nisl. Mauris malesuada condimentum risus ac aliquet. Suspendisse quis finibus lacus. Vivamus eu pulvinar mauris. Quisque dignissim, sapien vitae malesuada scelerisque, leo felis feugiat odio, ac dapibus ante sem viverra nisl. Quisque ac dui luctus, eleifend ex nec, porta tortor. Donec fermentum, enim eget convallis aliquet, sem tellus faucibus metus, a dapibus nibh orci a justo. Duis neque leo, sollicitudin sit amet sagittis non, molestie ut orci. Vivamus vulputate tincidunt auctor. Aliquam non arcu id erat congue tincidunt vitae aliquam dui. Mauris dictum lectus quam, a dictum magna auctor quis. Nullam leo lectus, sodales mollis eleifend sit amet, finibus ac metus. Fusce interdum ultricies erat a pellentesque. Sed venenatis quis tellus sit amet placerat. Nullam maximus dictum tristique. Maecenas interdum elementum tellus, eget aliquet magna pulvinar in. Suspendisse ornare erat nibh, nec faucibus nunc laoreet at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pharetra quam eu eros rutrum bibendum. Morbi eget metus eu libero laoreet interdum. Sed justo justo, efficitur rhoncus tempor id, pretium eget est. Suspendisse pharetra dui a nunc blandit congue. Nulla tellus sapien, malesuada non pulvinar eget, fringilla congue dui. Nunc aliquam sodales sodales. Donec ullamcorper dolor urna, in suscipit purus tempor a. Ut sollicitudin fermentum ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vestibulum sapien mi, quis condimentum neque dapibus sed. Vestibulum quis euismod lacus. Fusce rhoncus erat eget risus dignissim, sit amet lobortis nibh venenatis. Curabitur molestie, lorem et dictum maximus, ante nisl porta libero, non volutpat massa arcu sit amet purus. Nullam eu gravida lacus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse mollis urna eget lectus tincidunt sollicitudin. Cras efficitur dolor eu metus pretium, nec consectetur nibh luctus. Phasellus fermentum ante sit amet luctus malesuada. Etiam sodales diam id est tempor, eu iaculis tortor consectetur. Aliquam quis ante sed nibh ultricies ornare vitae sed urna. Phasellus vehicula eget dui sit amet dignissim. Nunc ac rhoncus lacus. Nulla facilisi. Suspendisse non augue nisl. Mauris malesuada condimentum risus ac aliquet. Suspendisse quis finibus lacus. Vivamus eu pulvinar mauris. Quisque dignissim, sapien vitae malesuada scelerisque, leo felis feugiat odio, ac dapibus ante sem viverra nisl. Quisque ac dui luctus, eleifend ex nec, porta tortor. Donec fermentum, enim eget convallis aliquet, sem tellus faucibus metus, a dapibus nibh orci a justo. '),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
