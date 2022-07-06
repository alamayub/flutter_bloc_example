import 'package:flutter/material.dart';

class PhotoGalleryView extends StatefulWidget {
  const PhotoGalleryView({Key? key}) : super(key: key);

  @override
  State<PhotoGalleryView> createState() => _PhotoGalleryViewState();
}

class _PhotoGalleryViewState extends State<PhotoGalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
