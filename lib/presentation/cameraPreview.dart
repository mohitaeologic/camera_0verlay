import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../capture/video_capture_bloc.dart';
import 'image_preview.dart';

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
    BlocProvider.of<VideoCaptureBloc>(context)..add(ControllerInitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : BlocConsumer<VideoCaptureBloc, VideoCaptureState>(
        listener: (context, state) {
          if (state is VideoRecordFinishedState) {
            final route = MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => ImagePreviewPage(filePath: state.file.path),
            );

            Navigator.push(context, route);
          }
          if (state is ControllerInitializedState) {
            // setState(() {
            //   // _cameraController = state.cameraController;
            // });
          }
        },
        builder: (context, state) {
          return Column(
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
                    CameraPreview(state.cameraController) :
                    Container()),
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
                            padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.flash_off,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    print('flash on called');
                                    if (state is CameraFlashState)
                                      BlocProvider.of<VideoCaptureBloc>(context)..add(FlashToggleEvent(isFlashOn: state.isFlashOn));
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
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.fiber_manual_record_outlined,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<VideoCaptureBloc>(context)..add(VideoRecordStartedEvent());
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.flip_camera_ios,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<VideoCaptureBloc>(context)..add(SwitchCameraEvent());
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
          );
        },
      ),
    );
  }

// get current lens direction (front / rear)
// void _toggleCameraLens(_availableCameras) {
//   final lensDirection = _cameraController.description.lensDirection;
//   CameraDescription newDescription;
//   if (lensDirection == CameraLensDirection.front) {
//     newDescription = _availableCameras.firstWhere((description) =>
//     description.lensDirection == CameraLensDirection.back);
//   } else {
//     newDescription = _availableCameras.firstWhere((description) =>
//     description.lensDirection == CameraLensDirection.front);
//   }
//
//   if (newDescription != null) {
//     _initCamera(newDescription);
//   } else {
//     print('Asked camera not available');
//   }
// }
}
