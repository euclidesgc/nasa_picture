import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/entities/media_entity.dart';

class DetailPage extends StatelessWidget {
  final MediaEntity media;

  const DetailPage({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture detail'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(media.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(media.date))}", style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            Image.network(media.hdurl),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  media.explanation,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
