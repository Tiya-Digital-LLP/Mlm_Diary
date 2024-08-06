import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/about_me.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/my_profile_card.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/social_button.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' as io;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final userProfile = Get.arguments as GetUserProfileUserProfile;
  final EditPostController controller = Get.put(EditPostController());
  //image
  Rx<io.File?> file = Rx<io.File?>(null);
  static List<io.File> imagesList = <io.File>[];
  final ImagePicker _picker = ImagePicker();

  // video
  // late VideoPlayerController _videoPlayerController;
  // // static List<io.File> videoList = <io.File>[];
  Rx<io.File?> videoFile = Rx<io.File?>(null);

  RxBool isFollowing = false.obs;
  final ProfileController profileController = Get.put(ProfileController());
  void deletePost(int index) async {
    int newsId = controller.myPostList[index].id ?? 0;
    await controller.deletePost(newsId, index, context);
  }

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      personlaInfo(),
                      20.sbh,
                      axisScroll(),
                    ],
                  ),
                ),
                const Divider(color: Colors.black26, height: 2.0),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 1.5,
                labelColor: AppColors.primaryColor,
                tabs: [
                  Tab(text: 'Posts (${userProfile.totalPost})'),
                  const Tab(text: 'About Me'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      posts(),
                      Container(
                        color: AppColors.background,
                        child: Obx(() {
                          if (controller.isLoading.value &&
                              controller.myPostList.isEmpty) {
                            return Center(
                                child: CustomLottieAnimation(
                              child: Lottie.asset(
                                Assets.lottieLottie,
                              ),
                            ));
                          }

                          if (controller.myPostList.isEmpty) {
                            return Center(
                              child: Text(
                                controller.isLoading.value
                                    ? 'Loading...'
                                    : 'Data not found',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.myPostList.length,
                              itemBuilder: (context, index) {
                                final post = controller.myPostList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.mypostdetails,
                                        arguments: post,
                                      );
                                    },
                                    child: MyProfileCard(
                                      onDelete: () => deletePost(index),
                                      userImage: post.userData!.imagePath ?? '',
                                      userName: post.userData!.name ?? '',
                                      postCaption: post.comments ?? '',
                                      postImage: post.attachmentPath ?? '',
                                      dateTime: post.createdate ?? '',
                                      likedCount: post.totallike ?? 0,
                                      postId: post.id ?? 0,
                                      controller: controller,
                                      bookmarkCount: post.totalbookmark ?? 0,
                                      commentcount: post.totalcomment ?? 0,
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Column(
                    children: [
                      AboutMeSection(size: size),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(30)),
        width: 150,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.messagescreen);
          },
          child: const SocialButton(icon: Assets.svgChat, label: 'Message'),
        ),
      ),
    );
  }

  Widget posts() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: AppColors.white,
          ),
          height: 65,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: AppColors.blackText, fontSize: 14),
                  controller: controller.comments.value,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if (file.value == null &&
                                  videoFile.value == null) {
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => bottomsheet(),
                                );
                              } else {
                                showToasterrorborder(
                                    'Select only one image or video', context);
                              }
                            },
                            child: file.value == null
                                ? SvgPicture.asset(
                                    Assets.svgImage,
                                    height: 30,
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          file.value!,
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: -2,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              imagesList.remove(file.value);
                                              file.value = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColors.redText,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     if (file.value == null &&
                          //         videoFile.value == null) {
                          //       _selectVideo();
                          //     } else {
                          //       showToasterrorborder(
                          //           'Select only one image or video',
                          //           context);
                          //     }
                          //   },
                          //   child: videoFile.value == null
                          //       ? SvgPicture.asset(
                          //           Assets.svgVideo,
                          //           height: 30,
                          //         )
                          //       : Stack(
                          //           children: [
                          //             ClipRRect(
                          //               borderRadius:
                          //                   BorderRadius
                          //                       .circular(
                          //                           13.05),
                          //               child: AspectRatio(
                          //                 aspectRatio:
                          //                     _videoPlayerController
                          //                         .value
                          //                         .aspectRatio,
                          //                 child: VideoPlayer(
                          //                     _videoPlayerController),
                          //               ),
                          //             ),
                          //             Positioned(
                          //               top: -2,
                          //               right: 0,
                          //               child:
                          //                   GestureDetector(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     videoList.remove(
                          //                         videoFile
                          //                             .value);
                          //                     videoFile
                          //                             .value =
                          //                         null;
                          //                   });
                          //                 },
                          //                 child: Icon(
                          //                   Icons.delete,
                          //                   color: AppColors
                          //                       .redText,
                          //                   size: 16,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          // ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.addPost(
                                imageFile: file.value,
                                videoFile: videoFile.value,
                              );
                            },
                            child: const Icon(
                              Icons.arrow_right_rounded,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Write Something',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget personlaInfo() {
    final Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (userProfile.imagePath!.isNotEmpty &&
            Uri.tryParse(userProfile.imagePath!)?.hasAbsolutePath == true)
          InkWell(
            onTap: () {
              _showFullScreenDialog(context);
            },
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipOval(
                child: Image.network(
                  '${userProfile.imagePath.toString()}?${DateTime.now().millisecondsSinceEpoch}',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.imagesAdminlogo,
                      fit: BoxFit
                          .cover, // Ensure the error image also uses BoxFit.cover
                    );
                  },
                ),
              ),
            ),
          ),
        30.sbw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProfile.name ?? 'N/A',
                style: textStyleW700(size.width * 0.045, AppColors.blackText),
              ),
              Text(
                '${userProfile.city ?? 'N/A'}, ${userProfile.state ?? 'N/A'}, ${userProfile.country ?? 'N/A'}',
                style: textStyleW500(
                  size.width * 0.035,
                  AppColors.blackText,
                ),
              ),
              Text(
                userProfile.company ?? 'N/A',
                style: textStyleW500(size.width * 0.035, AppColors.blackText),
              ),
              Text(
                userProfile.plan ?? 'N/A',
                style: textStyleW500(size.width * 0.035, AppColors.blackText),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InteractiveViewer(
                  child: Image.network(
                    '${userProfile.imagePath.toString()}?${DateTime.now().millisecondsSinceEpoch}',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget axisScroll() {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Get.toNamed(Routes.accountsettingscreen);
              },
              child: Text(
                'Edit Profile',
                style: textStyleW700(size.width * 0.030, AppColors.white),
              ),
            ),
          ),
          20.sbw,
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.followers);
                    },
                    child: Column(
                      children: [
                        Text(
                          userProfile.followersCount.toString(),
                          style: textStyleW700(
                              size.width * 0.045, AppColors.blackText),
                        ),
                        Text(
                          'Followers',
                          style: textStyleW500(
                              size.width * 0.035, AppColors.blackText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.sbw,
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.followers);
                    },
                    child: Column(
                      children: [
                        Text(
                          userProfile.followingCount.toString(),
                          style: textStyleW700(
                              size.width * 0.045, AppColors.blackText),
                        ),
                        Text(
                          'Following',
                          style: textStyleW500(
                              size.width * 0.035, AppColors.blackText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.sbw,
              Column(
                children: [
                  Text(
                    userProfile.views.toString(),
                    style:
                        textStyleW700(size.width * 0.045, AppColors.blackText),
                  ),
                  Text(
                    'Profile Visits',
                    style:
                        textStyleW500(size.width * 0.035, AppColors.blackText),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    phoneNumber = '+91${phoneNumber.replaceAll(RegExp(r'[^0-9]'), '')}';
    if (kDebugMode) {
      print('Making phone call to $phoneNumber');
    }
    final String url = 'tel:$phoneNumber';
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error launching phone call: $e');
      }
    }
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 18.0, color: AppColors.blackText),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.camera,
                    );
                  },
                  icon: Icon(Icons.camera, color: AppColors.primaryColor),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              TextButton.icon(
                  onPressed: () {
                    takephoto(
                      ImageSource.gallery,
                    );
                  },
                  icon: Icon(Icons.image, color: AppColors.primaryColor),
                  label: Text(
                    'Gallary',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource imageSource) async {
    final pickedfile =
        await _picker.pickImage(source: imageSource, imageQuality: 100);
    if (pickedfile != null) {
      io.File imageFile = io.File(pickedfile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;

      if (kDebugMode) {
        print('Original image size: $fileSizeInKB KB');
      }

      if (fileSizeInKB > 5000) {
        Fluttertoast.showToast(msg: 'Please Select an image below 5 MB');
        return;
      }

      io.File? processedFile = imageFile;

      if (fileSizeInKB > 250) {
        processedFile = await _cropImage(imageFile);
        if (processedFile == null) {
          Fluttertoast.showToast(msg: 'Please select an image');
          if (kDebugMode) {
            print('failed to compress image');
          }
          return;
        }
        processedFile = await _compressImage(processedFile);
      }

      double processedFileSizeInKB = processedFile!.lengthSync() / 1024;
      if (kDebugMode) {
        print('Processed image size: $processedFileSizeInKB KB');
      }

      setState(() {
        file.value = processedFile;
      });

      if (file.value != null) {
        imagesList.add(file.value!);
      }

      Get.back();
    } else {
      // ignore: use_build_context_synchronously
      showToasterrorborder('Please select an image', context);
      return; // Exit function if no image is selected
    }
  }

  Future<io.File?> _cropImage(io.File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      return io.File(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<io.File?> _compressImage(io.File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/temp.jpg';

    int quality = 90;
    io.File? compressedFile;
    while (true) {
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: quality,
      );

      if (result == null) {
        return null;
      }

      compressedFile = io.File(result.path);
      double fileSizeInKB = compressedFile.lengthSync() / 1024;

      if (fileSizeInKB <= 250 && fileSizeInKB >= 200) {
        break;
      }

      if (fileSizeInKB < 200) {
        quality += 5;
      } else {
        quality -= 5;
      }

      if (quality <= 0 || quality > 100) {
        break;
      }
    }

    return compressedFile;
  }

  // void _selectVideo() async {
  //   final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     io.File video = io.File(pickedFile.path);
  //     setState(() {
  //       videoFile.value = video;
  //       _videoPlayerController = VideoPlayerController.file(video)
  //         ..initialize().then((_) {
  //           // Play the video immediately after initialization
  //           _videoPlayerController.play();
  //           // Listen for video playback status changes
  //           _videoPlayerController.addListener(() {
  //             if (_videoPlayerController.value.position ==
  //                 _videoPlayerController.value.duration) {
  //               // If the video reaches the end, seek to the beginning and play again
  //               _videoPlayerController.seekTo(Duration.zero);
  //               _videoPlayerController.play();
  //             }
  //           });
  //         });
  //     });
  //   }
  // }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
