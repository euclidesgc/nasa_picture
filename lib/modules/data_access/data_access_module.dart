import 'package:flutter_modular/flutter_modular.dart';

import 'dio_http_client.dart';
import 'i_http_client.dart';
import 'local_storage/i_local_storage.dart';
import 'local_storage/local_storage.dart';

class DataAccessModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<IHttpClient>((i) => DioHttpClient(), export: true),
        Bind.singleton<ILocalStorage>((i) => LocalStorage(), export: true),
      ];
}
