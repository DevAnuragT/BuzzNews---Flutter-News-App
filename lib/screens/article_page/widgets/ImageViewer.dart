import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class ImageViewer extends StatelessWidget {
  final String? imageUrl;

  ImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          Positioned.fill(
            child: imageUrl != null &&
                imageUrl!.isNotEmpty &&
                imageUrl != 'https://via.placeholder.com/150'
                ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/Photos/default_news.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          // Centered main image with zoom functionality
          Center(
            child: imageUrl != null &&
                imageUrl!.isNotEmpty &&
                imageUrl != 'https://via.placeholder.com/150'
                ? PhotoView(
              imageProvider: NetworkImage(imageUrl!),
              minScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              backgroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  opacity: 0,
                ),
              ),
              errorBuilder: (context, error, stackTrace) => Center(
                child: Image.asset(
                  'assets/Photos/default_news.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            )
                : PhotoView(
              imageProvider: AssetImage('assets/Photos/default_news.png'),
              minScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              backgroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Photos/default_news.png'),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  opacity: 0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust the position according to your needs
            left: 20,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
