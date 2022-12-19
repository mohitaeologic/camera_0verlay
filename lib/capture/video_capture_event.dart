part of 'video_capture_bloc.dart';

@immutable
abstract class VideoCaptureEvent extends Equatable {}

class ControllerInitializeEvent extends VideoCaptureEvent {
  @override
  List<Object?> get props => [];
}

class VideoRecordStartedEvent extends VideoCaptureEvent {
  @override
  List<Object?> get props => [];
}

class Capture3DEvent extends VideoCaptureEvent {
  @override
  List<Object?> get props => [];
}

class VideoRecordCompetedEvent extends VideoCaptureEvent {
  @override
  List<Object?> get props => [];
}

class FlashToggleEvent extends VideoCaptureEvent {
  bool isFlashOn = false;
  @override
  List<Object?> get props => [isFlashOn];
  FlashToggleEvent({required this.isFlashOn});
}

class SwitchCameraEvent extends VideoCaptureEvent {
  @override
  List<Object?> get props => [];
  // SwitchCameraEvent();
}
