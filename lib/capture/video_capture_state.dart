part of 'video_capture_bloc.dart';

@immutable
abstract class VideoCaptureState extends Equatable {}

class ControllerInitializingState extends VideoCaptureState {
  @override
  List<Object?> get props => [];
}

class VideoRecordStartedState extends VideoCaptureState {
  @override
  List<Object?> get props => [];
}

class VideoRecordFinishedState extends VideoCaptureState {
  final file;
  VideoRecordFinishedState({required this.file});

  @override
  List<Object?> get props => [];
}

class ControllerInitializedState extends VideoCaptureState {
  final CameraController cameraController;
  ControllerInitializedState({required this.cameraController});

  @override
  List<Object?> get props => [cameraController];
}

class CameraFlashState extends VideoCaptureState {
  final bool isFlashOn = true;
  CameraFlashState({required isFlashOn});

  @override
  List<Object?> get props => [isFlashOn];
}
