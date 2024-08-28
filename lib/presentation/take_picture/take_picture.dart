import 'package:anj_techtest/service/serivce_picture.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:anj_techtest/service/service_database.dart';
import 'package:anj_techtest/service/service_location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';

class TakePicturePage extends StatefulWidget {
  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  final ImagePicker _picker = ImagePicker();
  final DatabaseService _databaseService = DatabaseService();
  final LocationService _locationService = LocationService();
  File? _imageFile;
  String? _savedImagePath;
  Position? _position;
  String? _currentTime;

  Future<void> _capturePicture() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        setState(() {
          _imageFile = imageFile;
        });

        // Get current location and time
        _position = await _locationService.getCurrentLocation();
        _currentTime = DateTime.now().toIso8601String();
      }
    } catch (e) {
      // Handle errors, such as location permission errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $e')),
      );
    }
  }

  Future<void> _savePicture() async {
    if (_imageFile != null && _position != null && _currentTime != null) {
      try {
        _savedImagePath = await _saveImageToLocalStorage(_imageFile!);

        final picture = PictureModel(
          imagePath: _savedImagePath!,
          latitude: _position!.latitude,
          longitude: _position!.longitude,
          datetime: _currentTime!,
        );

        await _databaseService.insertPicture(picture);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Picture saved successfully!')),
        );

        // Clear the state after saving
        setState(() {
          _imageFile = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save picture: $e')),
        );
      }
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
        title: const Text('Back'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Image.asset('assets/camera-placeholder.jpg'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _capturePicture,
              child: const Text('Capture Image'),
            ),
            if (_imageFile != null)
              Column(
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _savePicture,
                    child: const Text('Save Picture'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
