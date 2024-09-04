import 'package:anj_techtest/bloc/covid_bloc.dart';
import 'package:anj_techtest/data/datasource/remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CovidBusinessLogicalScreen extends StatelessWidget {
  const CovidBusinessLogicalScreen({super.key});

  String formatDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('EEEE, dd MMMM yyyy, hh:mm:ss').format(date);

    // EEEE, d MMMM yyyy HH:mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CovidBloc(remoteDatasource: RemoteDatasource())..add(LoadCovid()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Back'),
          backgroundColor: Colors.amber,
        ),
        body: BlocBuilder<CovidBloc, CovidState>(
          builder: (context, state) {
            if (state is CovidLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CovidError) {
              return Center(child: Text(state.error));
            } else if (state is CovidLoaded) {
              final data = state.attributes[0];
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
                          '${data.confirmed}',
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
                          '${data.deaths}',
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
                          '${data.recoverd}',
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
                            formatDate(data.lastupdate),
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
            return const Center(child: Text('Tidak ada data yang tersedia!'));
          },
        ),
      ),
    );
  }
}
