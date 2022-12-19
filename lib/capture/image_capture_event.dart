part of 'image_capture_bloc.dart';

@immutable
abstract class ImageCaptureEvent extends Equatable {}

class ControllerInitializeEvent extends ImageCaptureEvent {
  @override
  List<Object?> get props => [];
}

class VideoRecordStartedEvent extends ImageCaptureEvent {
  @override
  List<Object?> get props => [];
}

class Capture3DEvent extends ImageCaptureEvent {
  @override
  List<Object?> get props => [];
}

class VideoRecordCompetedEvent extends ImageCaptureEvent {
  @override
  List<Object?> get props => [];
}

class FlashToggleEvent extends ImageCaptureEvent {
  bool isFlashOn = false;
  @override
  List<Object?> get props => [isFlashOn];
  FlashToggleEvent({required this.isFlashOn});
}

class SwitchCameraEvent extends ImageCaptureEvent {
  @override
  List<Object?> get props => [];
  // SwitchCameraEvent();
}
