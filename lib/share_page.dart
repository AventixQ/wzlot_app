import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'package:camera/camera.dart';
import 'package:wZlot/main.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';


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
          height: 500.0,
          child: CameraPreview(_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "images\\camera_photo.png",
              height: 490.0,
              width: 345.0,
              ),
          ),
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
  final XFile file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  File? _mergedImage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mergeImages();
  }

  Future<void> _mergeImages() async {
    try {
      print('Reading');
      final imageBytes = await widget.file.readAsBytes();
      final img.Image? photo = img.decodeImage(imageBytes);
      if (photo == null) {
        throw Exception('Failed to decode photo');
      }
      print('Decoded successfully');

      print('Reading');
      final frameBytes = await rootBundle.load('images/camera_photo.png');
      final img.Image? frame = img.decodeImage(frameBytes.buffer.asUint8List());
      if (frame == null) {
        throw Exception('Failed to decode frame');
      }
      print('Decoded successfully');

      print('Calculating offsets');
      final int offsetX = (photo.width - frame.width) ~/ 2;
      final int offsetY = (photo.height - frame.height) ~/ 2;
      print('Offsets calculated: offsetX = $offsetX, offsetY = $offsetY');

      print('Merging images');
      final img.Image mergedImage = img.copyInto(photo, frame, dstX: offsetX, dstY: offsetY, blend: true);
      print('Images merged successfully');

      print('Saving merged image...');
      final directory = await getApplicationDocumentsDirectory();
      final mergedImagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_merged.png';
      final mergedFile = File(mergedImagePath);
      await mergedFile.writeAsBytes(img.encodePng(mergedImage));
      print('Merged image saved at $mergedImagePath');

      setState(() {
        _mergedImage = mergedFile;
        _isLoading = false;
      });
    } catch (e) {
      print('Error during image merging: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

    Future<void> _saveImageToGallery() async {
      if (_mergedImage != null) {
        await GallerySaver.saveImage(_mergedImage!.path);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved to gallery')));
      }
    }

    Future<void> _shareImage() async{
      if (_mergedImage != null) {
        Share.shareFiles([_mergedImage!.path]);
      }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Pochwal się gdzie jesteś!"),
      drawer: MainDrawer(),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_mergedImage != null) Image.file(_mergedImage!),
                ],
              ),
      ),
      bottomNavigationBar: _isLoading
          ? null
          : BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 40, color: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.download, size: 40, color: Colors.orange),
                    onPressed: _saveImageToGallery,
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 40, color: Colors.orange),
                    onPressed: _shareImage,
                  ),
                ],
              ),
            ),
    );
  }
}