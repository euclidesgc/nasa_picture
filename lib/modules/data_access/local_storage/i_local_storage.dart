abstract class ILocalStorage {
  create(String key, String value);
  Future<String> read(String key);
  update(String key, String value);
  delete(String key);
}
