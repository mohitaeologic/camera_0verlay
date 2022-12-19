import 'dart:io';

import 'package:camera_0verlay/capture/image_capture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThreeDimImageSelect extends StatefulWidget {
  const ThreeDimImageSelect({Key? key}) : super(key: key);

  @override
  State<ThreeDimImageSelect> createState() => _ThreeDimImageSelectState();
}

class _ThreeDimImageSelectState extends State<ThreeDimImageSelect> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: ElevatedButton(
          child: Text('Generate Image'),

          onPressed: (){},
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
            listener: (context, state)async {

              if (state is ImageCaptureFinishedState){

              }
              if (state is ControllerInitializedState) {

              }
            },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 12,top: 12,right: 12,bottom: 50),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,crossAxisSpacing: 5,mainAxisSpacing: 5,childAspectRatio: 1),
                  itemCount: 50,
                  itemBuilder: (context,index){
                    return context.read<ImageCaptureBloc>().images.asMap().containsKey(index) ? Image.file(File(context.read<ImageCaptureBloc>().images[index].path)):Container(
                      color: Colors.grey,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){},
                      ),
                    );
                  },
                ),
            );
          }
        ),
      ),

    );
  }
}
