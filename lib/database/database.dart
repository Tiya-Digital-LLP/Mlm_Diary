import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/database/user_card.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menu/menuscreens/profile/controller/edit_post_controller.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseState();
}

class _DatabaseState extends State<DatabaseScreen> {
  final _loc = TextEditingController();
  final DatabaseController controller = Get.put(DatabaseController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final EditPostController editPostController = Get.put(EditPostController());

  String googleApikey = "AIzaSyB3s5ixJVnWzsXoUZaP9ISDp_80GXWJXuU";
  late double lat = 0.0;
  late double log = 0.0;
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'database';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    _refreshData();
    videoController.fetchVideo(position, context);
  }

  Future<void> _refreshData() async {
    controller.clearFields();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustonTestAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Database',
        onTap: () {},
        position: position,
        homeScreenController: homeScreenController,
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.background),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: AppColors.white,
                          ),
                          height: 40,
                          child: TextFormField(
                            controller:
                                controller.clasifiedController.location.value,
                            readOnly: true,
                            style: TextStyle(
                              color: AppColors.blackText,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                            onTap: () async {
                              var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: googleApikey,
                                mode: Mode.fullscreen,
                                hint: 'Search and Save Location.',
                                cursorColor: AppColors.primaryColor,
                                types: ['geocode', 'establishment'],
                                strictbounds: false,
                                onError: (err) {},
                              );

                              if (place != null) {
                                setState(() {
                                  controller.clasifiedController.location.value
                                      .text = place.description.toString();
                                  _loc.text = controller
                                      .clasifiedController.location.value.text;
                                  _refreshData();
                                });
                                final plist = GoogleMapsPlaces(
                                  apiKey: googleApikey,
                                  apiHeaders: await const GoogleApiHeaders()
                                      .getHeaders(),
                                );
                                String placeid = place.placeId ?? "0";
                                final detail =
                                    await plist.getDetailsByPlaceId(placeid);
                                for (var component
                                    in detail.result.addressComponents) {
                                  for (var type in component.types) {
                                    if (type == "administrative_area_level_1") {
                                      controller.clasifiedController.state.value
                                          .text = component.longName;
                                    } else if (type == "locality") {
                                      controller.clasifiedController.city.value
                                          .text = component.longName;
                                    } else if (type == "country") {
                                      controller.clasifiedController.country
                                          .value.text = component.longName;
                                    }
                                  }
                                }

                                final geometry = detail.result.geometry!;
                                setState(() {
                                  lat = geometry.location.lat;
                                  log = geometry.location.lng;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    controller.clearFields();
                                  },
                                  child: const Icon(Icons.clear_sharp)),
                              hintText: "Location",
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackText,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  controller.clasifiedController
                                      .locationValidation();
                                });
                              } else {}
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (value.isEmpty) {
                                Fluttertoast.showToast(
                                    timeInSecForIosWeb: 2,
                                    msg:
                                        'Please Search and Save your Business Location');
                                setState(() {
                                  controller.clasifiedController
                                      .locationValidation();
                                });
                              } else if (value.isNotEmpty) {
                                setState(() {
                                  controller.clasifiedController
                                      .locationValidation();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      child: CustomSearchInput(
                        controller: controller.search,
                        onSubmitted: (value) {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();

                          _refreshData();
                        },
                        onChanged: (value) {
                          WidgetsBinding.instance.focusManager.primaryFocus;
                          if (value.isNotEmpty) {
                            _refreshData();
                          } else {
                            _refreshData();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const BottomSheetContent();
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.048,
                        width: size.height * 0.048,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(Assets.svgFilter),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.mlmDatabaseList.isEmpty) {
                  return Center(
                    child: CustomLottieAnimation(
                      child: Lottie.asset(
                        Assets.lottieLottie,
                      ),
                    ),
                  );
                }

                if (controller.mlmDatabaseList.isEmpty) {
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
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.mlmDatabaseList.length +
                            (controller.isLoading.value ? 1 : 0),
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == controller.mlmDatabaseList.length) {
                            return Center(
                              child: CustomLottieAnimation(
                                child: Lottie.asset(
                                  Assets.lottieLottie,
                                ),
                              ),
                            );
                          }
                          final post = controller.mlmDatabaseList[index];
                          String location =
                              '${post.city ?? ''}, ${post.state ?? ''}, ${post.country ?? ''}'
                                  .trim();
                          if (location == ', ,') {
                            location = 'N/A';
                          }

                          return GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? apiToken =
                                  prefs.getString(Constants.accessToken);

                              if (apiToken == null) {
                                // ignore: use_build_context_synchronously
                                showSignupDialog(context);
                                return;
                              }
                              Get.toNamed(Routes.userprofilescreen,
                                  arguments: {'user_id': post.id});
                              await userProfileController.fetchUserAllPost(
                                  1, post.id.toString());
                              editPostController.countViewUserProfile(
                                  post.id ?? 0,
                                  // ignore: use_build_context_synchronously
                                  context);
                            },
                            child: UserCard(
                              post: post,
                              postid: post.id ?? 0,
                              userprofilecontroller: userProfileController,
                              userImage: post.imagePath ?? '',
                              userName: post.name ?? '',
                              location: location,
                              designation: post.immlm ?? '',
                              plan: post.plan ?? '',
                            ),
                          );
                        }),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

void showSignupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SignupDialog();
    },
  );
}
