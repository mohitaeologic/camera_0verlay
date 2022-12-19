import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'image_capture_event.dart';
part 'image_capture_state.dart';

class ImageCaptureBloc extends Bloc<ImageCaptureEvent, ImageCaptureState> {
  bool cameraFlash = false;
  late final cameras;
  late CameraController _cameraController;
  List<XFile> _images = [];
  List<XFile> get images => _images;

  ImageCaptureBloc() : super(ControllerInitializingState()) {
    on<ControllerInitializeEvent>((event, emit) async {
      emit(ControllerInitializingState());
      cameras = await availableCameras();
      await _initCamera(null);
      print('controller intialized state ');
      emit(ControllerInitializedState(cameraController: _cameraController));
    });

    on<SwitchCameraEvent>((event, emit) async {
      emit(ControllerInitializingState());
      CameraDescription newDescription = await _toggleCameraLens(cameras);
      await _initCamera(newDescription);
      emit(ControllerInitializedState(cameraController: _cameraController));
    });

    on<VideoRecordStartedEvent>((event, emit) async {
      emit(ControllerInitializedState(cameraController: _cameraController));
      final file = await _cameraController.takePicture();
      emit(ImageCaptureFinishedState(file: file));
    });

    on<FlashToggleEvent>((event, emit) async {
      if (cameraFlash == false) {
        _cameraController.setFlashMode(FlashMode.always);
        cameraFlash = true;
        // emit(CameraFlashState(isFlashOn: cameraFlash));
      } else {
        _cameraController.setFlashMode(FlashMode.off);
        cameraFlash = false;
        // emit(CameraFlashState(isFlashOn: cameraFlash));
      }
    });

    on<Capture3DEvent>((event, emit) async {
      emit(ControllerInitializedState(cameraController: _cameraController));

      final file = await _cameraController.takePicture();
      _images.add(file);
      emit(ImageCaptureFinishedState(file: file));
    });
  }

  _initCamera(CameraDescription? description) async {
    if (description == null) {
      final front = await cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      _cameraController = await CameraController(front, ResolutionPreset.max);
      await _cameraController.initialize();
      return _cameraController;
    } else {
      print('camera front controller called ');
      _cameraController = CameraController(description, ResolutionPreset.max);
      await _cameraController.initialize();
      return _cameraController;
    }
  }

  // get current lens direction (front / rear)
  _toggleCameraLens(_availableCameras) {
    final lensDirection = _cameraController.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
      return newDescription;
    } else {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
      return newDescription;
    }
  }
}
