import 'dart:io';

import 'package:flutter/material.dart';
import 'package:w_zlot/app_bar.dart';
import 'package:w_zlot/drawer.dart';
import 'package:camera/camera.dart';
import 'package:w_zlot/main.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "Pochwal się gdzie jesteś!"),
        drawer: MainDrawer(),
        body: CameraApp());
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[selectedCameraIndex], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('access denied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  void onSwitchCamera() {
    selectedCameraIndex = selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraController newController = CameraController(
      cameras[selectedCameraIndex],
      ResolutionPreset.max,
    );

    newController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _controller = newController;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 600.0,
          child: CameraPreview(_controller),
        ),
        Align(
          child: Image.asset("images\\camera_photo.png"),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () async {
                        if (!_controller.value.isInitialized) {
                          return null;
                        }
                        if (_controller.value.isTakingPicture) {
                          return null;
                        }

                        try {
                          await _controller.setFlashMode(FlashMode.auto);
                          XFile picture = await _controller.takePicture();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagePreview(picture)));
                        } on CameraException catch (e) {
                          debugPrint("Error : $e");
                          return null;
                        }
                      },
                      child: Icon(
                        Icons.camera_alt,
                        size: 40.0,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(width: 10),
                    MaterialButton(
                      onPressed: onSwitchCamera,
                      child: Icon(
                        Icons.switch_camera,
                        size: 40.0,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}


class ImagePreview extends StatefulWidget {
  ImagePreview(this.file, {super.key});
  XFile file;
  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return Scaffold(
        appBar: MainAppBar(title: "Pochal się gdzie jesteś!"),
        drawer: MainDrawer(),
        body: Center(
          child: Image.file(picture),
        ));
  }
}
