import 'package:flutter/foundation.dart';

import '../entities/media_entity.dart';
import '../repositories/i_home_repository.dart';

class GetNasaMediaUsecase {
  final IHomeRepository repository;

  GetNasaMediaUsecase(this.repository);

  Future<List<MediaEntity>> call(DateTime initialDate, DateTime finalDate) async {
    try {
      return await repository.getNasaMedia(initialDate: initialDate, finalDate: finalDate);
    } catch (e) {
      debugPrint("🟠 $e");
      throw Exception();
    }
  }
}
