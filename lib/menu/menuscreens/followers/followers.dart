import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class Folowers extends StatefulWidget {
  const Folowers({super.key});

  @override
  State<Folowers> createState() => _FolowersState();
}

class _FolowersState extends State<Folowers> with TickerProviderStateMixin {
  late TabController _tabController;
  final _search = TextEditingController();

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
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Followers',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
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
                    Tab(text: 'Followers (130)'),
                    Tab(text: 'Following (130k)'),
                  ],
                ),
              ),
              30.sbh,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomSearchInput(
                            controller: _search,
                            onSubmitted: (value) {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              setState(() {});
                            },
                            onChanged: (value) {
                              if (value.isEmpty) {
                                WidgetsBinding
                                    .instance.focusManager.primaryFocus;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        20.sbh,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.imagesIcon,
                                  height: 50,
                                ),
                                20.sbw,
                                Expanded(
                                    child: Text(
                                  'Aman Talaviya',
                                  style: textStyleW700(
                                      size.width * 0.030, AppColors.blackText),
                                )),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Following',
                                        style: textStyleW700(size.width * 0.030,
                                            AppColors.white),
                                      )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomSearchInput(
                            controller: _search,
                            onSubmitted: (value) {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              setState(() {});
                            },
                            onChanged: (value) {
                              if (value.isEmpty) {
                                WidgetsBinding
                                    .instance.focusManager.primaryFocus;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        20.sbh,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.imagesIcon,
                                  height: 50,
                                ),
                                20.sbw,
                                Expanded(
                                    child: Text(
                                  'Aman Talaviya',
                                  style: textStyleW700(
                                      size.width * 0.030, AppColors.blackText),
                                )),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Following',
                                        style: textStyleW700(size.width * 0.030,
                                            AppColors.white),
                                      )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
