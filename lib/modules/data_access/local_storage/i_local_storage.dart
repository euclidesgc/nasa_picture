import '../../home/data/models/local_media_model.dart';

abstract class ILocalStorage {
  Future<void> insertMedia(LocalMediaModel media);
  Future<List<LocalMediaModel>> getMediaList();
}
