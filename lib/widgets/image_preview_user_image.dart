import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class FullScreenImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero, // Remove padding
      backgroundColor: AppColors.background, // Make background transparent
      child: Stack(
        children: [
          FutureBuilder(
            future: _fetchImage(imageUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While loading, show a loading indicator
                return Center(
                  child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                // If there is an error, show an error message
                return const Center(child: Text('Error loading image'));
              } else {
                // If the image loads successfully, display it
                return InteractiveViewer(
                  child: Image.network(
                    '$imageUrl?${DateTime.now().millisecondsSinceEpoch}',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                );
              }
            },
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                Get.back(); // Close the dialog
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchImage(String url) async {
    // Simulating network delay; you can also perform actual image loading here.
    await Future.delayed(const Duration(seconds: 4));
  }
}
