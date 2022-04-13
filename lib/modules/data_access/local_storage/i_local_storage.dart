abstract class ILocalStorage {
  create(String key, String value);
  Future<dynamic> read(String key);
  update(String key, String value);
  delete(String key);
}
