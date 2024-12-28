import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMessageDetailScreen extends StatefulWidget {
  const UserMessageDetailScreen({super.key});

  @override
  State<UserMessageDetailScreen> createState() =>
      _UserMessageDetailScreenState();
}

class _UserMessageDetailScreenState extends State<UserMessageDetailScreen> {
  final MessageController messageController = Get.put(MessageController());
  final ProfileController profileController = Get.put(ProfileController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  late PostTimeFormatter postTimeFormatter;
  dynamic post;
  final ScrollController _scrollController = ScrollController();
  int? currentUserID;
  Timer? _timer;

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.userId);
  }

  Future<void> _getUserId() async {
    currentUserID = await getUserId();
    if (kDebugMode) {
      print('current_user_id: $currentUserID');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    post = Get.arguments;
    postTimeFormatter = PostTimeFormatter();
    _getUserId();
    if (post != null && post['chatId'] != null) {
      messageController.chatId.value = post['chatId'].toString();
      messageController.fetchMyChatDetail(post['chatId'].toString());
      _startFetchingNewMessages();
    }
  }

  // Timer function to fetch new messages
  void _startFetchingNewMessages() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (messageController.chatdetailsList.isNotEmpty) {
        messageController.fetchMyChatDetail(post.chatId.toString());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                Assets.svgBack,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  Get.toNamed(
                    Routes.userprofilescreen,
                    arguments: {
                      'user_id': post['toid'],
                    },
                  );
                  await userProfileController.fetchUserAllPost(
                    1,
                    post['toid'].toString(),
                  );
                },
                child: Row(
                  children: [
                    if (post != null && post['imageUrl'] != null) ...[
                      ClipOval(
                        child: Image.network(
                          post['imageUrl'],
                          height: 30.0,
                          width: 30.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      10.sbw,
                    ],
                    Text(
                      post['username'] ?? 'Unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (value) {
              if (value == 1) {
                LogoutDialog.show(context, () async {
                  messageController.deleteChat(
                      chatId: post['chatId'].toString());
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Delete Chat"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    Assets.imagesBg,
                    fit: BoxFit.cover,
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    controller: _scrollController,
                    itemCount: messageController.chatdetailsList.length,
                    reverse: true,
                    itemBuilder: (_, index) {
                      final message = messageController.chatdetailsList[index];
                      final isSender =
                          message.fromid.toString() == currentUserID.toString();
                      final userImage = isSender
                          ? profileController.userImage
                          : post['profile_pic'];

                      return Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isSender)
                              ClipOval(
                                child: Image.network(
                                  userImage ?? '',
                                  height: 30.0,
                                  width: 30.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.error, size: 30),
                                ),
                              ),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSender
                                      ? AppColors.primaryColor
                                      // ignore: deprecated_member_use
                                      : AppColors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: isSender
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.msg ?? '',
                                      style: textStyleW400(14, AppColors.white),
                                    ),
                                    5.sbh,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          postTimeFormatter.formatPostTime(
                                              message.updatedAt!),
                                          style: textStyleW400(
                                            12,
                                            // ignore: deprecated_member_use
                                            AppColors.white.withOpacity(0.7),
                                          ),
                                        ),
                                        6.sbw,
                                        Icon(
                                          message.readStatus == 0
                                              ? Icons.check
                                              : Icons.done_all,
                                          size: 16,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isSender)
                              ClipOval(
                                child: Image.network(
                                  userImage ?? '',
                                  height: 30.0,
                                  width: 30.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.error, size: 30),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.svgPlusIcon,
                  height: 40,
                ),
                10.sbw,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.searchbar,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: messageController.msg.value,
                        decoration: const InputDecoration(
                          hintText: 'Write a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.primaryColor),
                  onPressed: () async {
                    await messageController.sendChat(
                      toId: post['toid'].toString(),
                      chatId: messageController.chatId.value,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
