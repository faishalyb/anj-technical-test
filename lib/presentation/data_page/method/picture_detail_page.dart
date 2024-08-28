import 'package:anj_techtest/service/serivce_picture.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PictureDetailPage extends StatelessWidget {
  final PictureModel picture;

  const PictureDetailPage({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              File(picture.imagePath),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              picture.datetime,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${picture.latitude}, ',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  ' ${picture.longitude}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
