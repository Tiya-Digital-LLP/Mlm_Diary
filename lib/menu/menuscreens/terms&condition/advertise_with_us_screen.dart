// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class AddwertiseWithUs extends StatefulWidget {
  const AddwertiseWithUs({super.key});

  @override
  State<AddwertiseWithUs> createState() => _AdwithusState();
}

class Choice {
  const Choice(
      {required this.title,
      required this.type,
      required this.price,
      required this.size,
      required this.icon});

  final String title;
  final String type;
  final String price;
  final String size;
  final String icon;
}

List<Choice> choices = <Choice>[
  const Choice(
      title: 'Homepage Banner Advertisement',
      type: 'Image or Video',
      price: '₹25000/- Per Month',
      size: '1170 X 200 (pixels)',
      icon: Assets.imagesAdwithus3),
  const Choice(
      title: 'Pop-up Banner Advertisement',
      type: 'Image',
      price: '₹40000/- Per Month',
      size: '500 X 500 (pixels)',
      icon: Assets.imagesAdwithus1),
  const Choice(
      title: 'Premium Classified',
      type: 'Image',
      price: '₹5000/- Per Month',
      size: '550 X 200 (pixels)',
      icon: Assets.imagesAdwithus2),
];

class _AdwithusState extends State<AddwertiseWithUs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TermsController _termsController = Get.put(TermsController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _termsController.fetchTermsAndConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Advertise With Us',
        onTap: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            category(),

            const Text(
              'Terms And Conditions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            // TabBar for navigation
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
                  tabs: const [
                    Tab(text: 'Blog'),
                    Tab(text: 'Classified'),
                    Tab(text: 'News'),
                  ],
                ),
              ),
            ),
            // TabBarView for content
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
                            return const CircularProgressIndicator(); // or any other loading indicator
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

  Widget category() {
    final Size size = MediaQuery.of(context).size;

    return ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: choices.length,
        itemBuilder: (context, index) {
          Choice record = choices[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.05),
                ),
                shadows: [customBoxShadow()]),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      record.size.isNotEmpty
                          ? Container(
                              width: 112.68,
                              height: 228,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13.05)),
                                  child: Image(
                                    image: AssetImage(record.icon),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, object, trace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.background),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 134,
                              height: 152.11,
                              margin: const EdgeInsets.only(
                                  top: 22, left: 10, bottom: 20, right: 6),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(record.icon),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      15.sbw,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.title,
                                style: textStyleW700(
                                    size.width * 0.042, AppColors.blackText),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              10.sbh,
                              record.size.isNotEmpty
                                  ? SizedBox(
                                      height: 15,
                                      child: Text('Type:',
                                          style: textStyleW500(
                                              size.width * 0.028,
                                              AppColors.blackText),
                                          maxLines: 2,
                                          softWrap: false))
                                  : const SizedBox(),
                              5.sbh,
                              Text(
                                record.type,
                                style: record.size.isNotEmpty
                                    ? textStyleW600(
                                        size.width * 0.042, AppColors.blackText)
                                    : textStyleW500(size.width * 0.032,
                                        AppColors.blackText),
                                textAlign: TextAlign.justify,
                              ),
                              5.sbh,
                              record.size.isNotEmpty
                                  ? Text(
                                      'Size:',
                                      style: textStyleW500(size.width * 0.032,
                                          AppColors.blackText),
                                    )
                                  : const SizedBox(),
                              record.size.isNotEmpty
                                  ? Text(record.size,
                                      style: textStyleW600(size.width * 0.042,
                                          AppColors.blackText))
                                  : const SizedBox(),
                              5.sbh,
                              Text(
                                'Price:',
                                style: textStyleW500(
                                    size.width * 0.032, AppColors.blackText),
                              ),
                              Text(
                                record.price,
                                style: textStyleW600(
                                    size.width * 0.042, AppColors.blackText),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: NormalButton(
                        onPressed: () {
                          Get.toNamed(Routes.contactus);
                        },
                        text: 'Contact Us'),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
