import 'package:anj_techtest/presentation/covid_bloc/covid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:anj_techtest/presentation/api_covid/api_covid.dart';
import 'package:anj_techtest/presentation/data_page/data_page.dart';
import 'package:anj_techtest/presentation/take_picture/take_picture.dart';
import 'package:camera/camera.dart';

class HomePage extends StatelessWidget {
  final CameraDescription camera;

  const HomePage({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/anj-group.png'),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.amber),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakePicturePage(),
                    ),
                  );
                },
                child: const Text(
                  'Take a Photo',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.amber),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataPage(),
                    ),
                  );
                },
                child: const Text(
                  'List Data',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.amber),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ApiCovidPage(),
                    ),
                  );
                },
                child: const Text(
                  'API Covid-19',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.amber),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CovidBusinessLogicalScreen(),
                    ),
                  );
                },
                child: const Text(
                  'BLoc',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
