import 'package:anj_techtest/service/service_covid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class ApiCovidPage extends StatefulWidget {
  const ApiCovidPage({super.key});

  @override
  State<ApiCovidPage> createState() => _ApiCovidPageState();
}

class _ApiCovidPageState extends State<ApiCovidPage> {
  late Future<Map<String, dynamic>> covidData;

  @override
  void initState() {
    super.initState();
    covidData = ApiService().fetchCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: covidData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final data = snapshot.data!;
            final formattedDate =
                DateFormat('EEEE, d MMMM yyyy HH:mm:ss').format(
              DateTime.fromMillisecondsSinceEpoch(data['Last_Update']),
            );
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Confirmed       :  ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${data['Confirmed']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Deaths             :  ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${data['Deaths']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Recovered       :  ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${data['Recovered']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Last Update    :  ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: Text(
                          formattedDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
