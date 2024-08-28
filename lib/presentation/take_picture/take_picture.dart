import 'package:anj_techtest/service/serivce_picture.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:anj_techtest/service/service_database.dart';
import 'package:anj_techtest/service/service_location.dart';
import 'package:path_provider/path_provider.dart';

class TakePicturePage extends StatefulWidget {
  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  final ImagePicker _picker = ImagePicker();
  final DatabaseService _databaseService = DatabaseService();
  final LocationService _locationService = LocationService();
  File? _imageFile;

  Future<void> _captureAndSavePicture() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final savedImagePath = await _saveImageToLocalStorage(imageFile);

        final position = await _locationService.getCurrentLocation();
        final currentTime = DateTime.now().toIso8601String();

        final picture = PictureModel(
          imagePath: savedImagePath,
          latitude: position?.latitude ?? 0.0,
          longitude: position?.longitude ?? 0.0,
          datetime: currentTime,
        );

        await _databaseService.insertPicture(picture);

        setState(() {
          _imageFile = imageFile;
        });
      }
    } catch (e) {
      // Handle location permission errors or any other errors here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  Future<String> _saveImageToLocalStorage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final File localImage = await imageFile.copy(path);
    return localImage.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : const Text('No image selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureAndSavePicture,
              child: const Text('Capture Image'),
            ),
          ],
        ),
      ),
    );
  }
}
