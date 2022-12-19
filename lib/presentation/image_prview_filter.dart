import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreviewFilter extends StatefulWidget {
  final File imageFile;
  const ImagePreviewFilter({Key? key,required this.imageFile}) : super(key: key);

  @override
  State<ImagePreviewFilter> createState() => _ImagePreviewFilterState();
}

class _ImagePreviewFilterState extends State<ImagePreviewFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Filter Example'),
      ),
      body: Center(
        child: Container(
          child: widget.imageFile == null
              ? const Center(
            child: Text('No image selected.'),
          )
              : Image.file(File(widget.imageFile!.path)),
        ),
      ),
    );
  }
}
