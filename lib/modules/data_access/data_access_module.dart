import 'package:flutter_modular/flutter_modular.dart';

import 'dio_http_client.dart';

class DataAccessModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => DioHttpClient(), export: true),
      ];
}
