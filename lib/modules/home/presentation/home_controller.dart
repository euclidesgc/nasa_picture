import 'package:flutter/foundation.dart';

import '../domain/usecases/get_nasa_media_usecase.dart';

class HomeController {
  final GetNasaMediaUsecase usecase;

  HomeController({required this.usecase});

  getMedias() async {
    final startDate = DateTime.now().subtract(const Duration(days: 2));
    final endDate = DateTime.now();

    try {
      final result = await usecase(initialDate: startDate, finalDate: endDate);
      debugPrint("Home Controller: ${result.toString()}");
    } catch (e) {
      debugPrint("Home Controller: ${e.toString()}");
    }
  }
}
