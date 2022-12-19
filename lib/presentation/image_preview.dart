import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:image/image.dart' as imageLib;

class ImagePreviewPage extends StatefulWidget {
  final String filePath;
  final imageLib.Image image;
  const ImagePreviewPage({Key? key, required this.filePath,required this.image}) : super(key: key);

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  // late VideoPlayerController _videoPlayerController;

  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<VideoCaptureBloc>(context)..add(ControllerInitializeEvent());
  // }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   super.dispose();
  // }

  // Future _initVideoPlayer() async {
  //   _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
  //   await _videoPlayerController.initialize();
  //   await _videoPlayerController.setLooping(true);
  //   await _videoPlayerController.play();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PhotoFilterSelector(
          title: const Text("Image preview"),
          image: widget.image,
          filters: presetFiltersList,
          filename: widget.filePath,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
        // body: Image.file(File(widget.filePath))
    );
  }
}
