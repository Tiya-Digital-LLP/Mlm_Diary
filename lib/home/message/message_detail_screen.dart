import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/modal_class/post_class.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class MessageDetailsScreen extends StatefulWidget {
  final PostClass post;
  const MessageDetailsScreen({super.key, required this.post});

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Aman Talaviya',
      message: 'Hello!',
      isMe: false,
      imageUrl: Assets.imagesIcon,
    ),
    ChatMessage(
      sender: 'Me',
      message: 'Hi Aman!',
      isMe: true,
      imageUrl: Assets.imagesIcon,
    ),
  ];
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
              Row(
                children: [
                  Image.asset(
                    Assets.imagesIcon,
                    height: 40,
                  ),
                  10.sbw,
                  Text(
                    widget.post.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.imagesBg,
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!message.isMe)
                      CircleAvatar(
                        backgroundImage: AssetImage(message.imageUrl),
                      ),
                    8.sbw,
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: message.isMe ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message.message,
                          style: TextStyle(
                            color: message.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    8.sbw,
                    if (message.isMe)
                      CircleAvatar(
                        backgroundImage: AssetImage(message.imageUrl),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      height: 40,
                      Assets.svgPlusIcon,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Write your answer here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.svgSend,
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

class ChatMessage {
  final String sender;
  final String message;
  final bool isMe;
  final String imageUrl;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.isMe,
    required this.imageUrl,
  });
}
