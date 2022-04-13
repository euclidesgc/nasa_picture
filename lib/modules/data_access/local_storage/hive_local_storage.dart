import 'package:hive/hive.dart';

import 'i_local_storage.dart';

class HiveLocalStorage extends ILocalStorage {
  late Box box;

  HiveLocalStorage() {
    box = Hive.box('nasa_picture');
  }

  @override
  create(String key, dynamic value) {
    box.put(key, value);
  }

  @override
  Future<dynamic> read(String key) {
    return box.get(key);
  }

  @override
  update(String key, dynamic value) {
    box.put(key, value);
  }

  @override
  delete(String key) {
    box.delete(key);
  }
}
