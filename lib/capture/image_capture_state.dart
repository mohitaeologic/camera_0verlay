part of 'image_capture_bloc.dart';

@immutable
abstract class ImageCaptureState extends Equatable {}

class ControllerInitializingState extends ImageCaptureState {
  @override
  List<Object?> get props => [];
}

class VideoRecordStartedState extends ImageCaptureState {
  @override
  List<Object?> get props => [];
}

class ImageCaptureFinishedState extends ImageCaptureState {
  final file;
  ImageCaptureFinishedState({required this.file});

  @override
  List<Object?> get props => [];
}

class ControllerInitializedState extends ImageCaptureState {
  final CameraController cameraController;
  ControllerInitializedState({required this.cameraController});

  @override
  List<Object?> get props => [cameraController];
}

class CameraFlashState extends ImageCaptureState {
  final bool isFlashOn = true;
  CameraFlashState({required isFlashOn});

  @override
  List<Object?> get props => [isFlashOn];
}
