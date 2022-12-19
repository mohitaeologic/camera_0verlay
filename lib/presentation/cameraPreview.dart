import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_0verlay/presentation/image_prview_filter.dart';
import 'package:camera_0verlay/presentation/three_dim_image_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../capture/image_capture_bloc.dart';
import 'image_preview.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart' as path;

class VideoCaptureForm extends StatefulWidget {
  const VideoCaptureForm({Key? key}) : super(key: key);

  @override
  State<VideoCaptureForm> createState() => _VideoCaptureFormState();
}

class _VideoCaptureFormState extends State<VideoCaptureForm> {
  // late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ImageCaptureBloc>(context)
      .add(ControllerInitializeEvent());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ImageCaptureBloc>(
        create: (_) => ImageCaptureBloc(),
        child: BlocBuilder<ImageCaptureBloc, ImageCaptureState>(
          // listener: (context, state)async {
          //   if (state is VideoRecordFinishedState){
          //     File? imageFile = File(state.file.path);
          //     String? fileName = path.basename(imageFile.path);
          //     var image = imageLib.decodeImage(await imageFile.readAsBytes());
          //     Map imagefile  = await Navigator.push(context,MaterialPageRoute(
          //       fullscreenDialog: true,
          //       builder: (_) => ImagePreviewPage(filePath: fileName,image: image!),
          //     ));
          //
          //     Navigator.push(context, MaterialPageRoute(builder: (_) => ImagePreviewFilter(imageFile: imagefile['image_filtered'],)));
          //   }
          //   if (state is ControllerInitializedState) {
          //     // setState(() {
          //     //   // _cameraController = state.cameraController;
          //     // });
          //   }
          // },
          builder: (context, state) {
            return Stack(

              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child:
                          state is ControllerInitializedState ?
                          // CameraPreview(state.cameraController) :
                          CameraPreview(state.cameraController) : Container()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      40, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.threed_rotation_rounded,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => ThreeDimImageSelect()));

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      40, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.flash_off,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          print('flash on called');
                                          if (state is CameraFlashState) {
                                            BlocProvider.of<ImageCaptureBloc>(
                                                context)
                                                .add(FlashToggleEvent(
                                                isFlashOn: state.isFlashOn));
                                          }
                                          // _cameraController
                                          //     .setFlashMode(
                                          //         FlashMode
                                          //             .always);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        icon: const Icon(
                                          Icons.fiber_manual_record_outlined,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<ImageCaptureBloc>(
                                              context)
                                              .add(VideoRecordStartedEvent());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 40, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.flip_camera_ios,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<ImageCaptureBloc>(
                                              context)
                                              .add(SwitchCameraEvent());
                                          // _toggleCameraLens(
                                          //     cameras);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _getOverlay(),

              ],
            );
          },
        ),
      ),
    );
  }
}
Widget _getOverlay() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 50),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Positioned(child: Icon(Icons.person_outline,size: 150,color: Colors.black54,)),
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.srcOut
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(right: 4,top: 5,bottom: 30),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black, // Color does not matter but should not be transparent
                      borderRadius: BorderRadius.circular(300),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}