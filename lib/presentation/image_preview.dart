import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewPage extends StatefulWidget {
  final String filePath;

  const ImagePreviewPage({Key? key, required this.filePath}) : super(key: key);

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
        appBar: AppBar(
          title: Text("Image preview"),
          elevation: 0,
          backgroundColor: Colors.black26,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                print('do something with the file');
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Image.file(File(widget.filePath)));
  }
}
