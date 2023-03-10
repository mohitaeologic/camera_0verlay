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

class CameraPreview3D extends StatefulWidget {
  const CameraPreview3D({Key? key}) : super(key: key);

  @override
  State<CameraPreview3D> createState() => _CameraPreview3DState();
}

class _CameraPreview3DState extends State<CameraPreview3D> {
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
      body: BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
        listener: (context, state)async {
          if (state is ImageCaptureFinishedState){

          }
          if (state is ControllerInitializedState) {

          }
        },
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
                                        Icons.flash_off,
                                        size: 25,
                                      ),
                                      onPressed: () {

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