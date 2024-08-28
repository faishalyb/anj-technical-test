import 'package:anj_techtest/presentation/data_page/method/picture_detail_page.dart';
import 'package:anj_techtest/service/serivce_picture.dart';
import 'package:flutter/material.dart';
import 'package:anj_techtest/service/service_database.dart';
import 'package:intl/intl.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<List<PictureModel>> _pictures;

  @override
  void initState() {
    super.initState();
    _pictures = _fetchPictures();
  }

  Future<List<PictureModel>> _fetchPictures() async {
    final databaseService = DatabaseService();
    return await databaseService.getPictures();
  }

  String _formatDateTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<PictureModel>>(
        future: _pictures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pictures found.'));
          } else {
            final pictures = snapshot.data!;
            return ListView.builder(
              itemCount: pictures.length,
              itemBuilder: (context, index) {
                final picture = pictures[index];
                return ListTile(
                  title: Text(' ${_formatDateTime(picture.datetime)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PictureDetailPage(picture: picture),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
