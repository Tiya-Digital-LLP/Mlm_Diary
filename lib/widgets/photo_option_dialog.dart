import 'package:flutter/material.dart';

class PhotoOptionDialog extends StatelessWidget {
  final Function onCameraPressed;
  final Function onGalleryPressed;

  const PhotoOptionDialog(
      {super.key,
      required this.onCameraPressed,
      required this.onGalleryPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text(
                        'Choose',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              onCameraPressed();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Camera',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              onGalleryPressed();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Gallery',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            )));
  }
}
