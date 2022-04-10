import 'package:flutter_modular/flutter_modular.dart';

import '../data_access/data_access_module.dart';
import '../data_access/dio_http_client.dart';
import 'data/datasources/home_datasource.dart';
import 'data/repositories/home_repository.dart';
import 'domain/usecases/get_nasa_media_usecase.dart';
import 'presentation/home_controller.dart';
import 'presentation/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        DataAccessModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HomeDatasource(client: i<DioHttpClient>())),
        Bind.singleton((i) => HomeRepository(datasource: i<HomeDatasource>())),
        Bind.singleton((i) => GetNasaMediaUsecase(repository: i<HomeRepository>())),
        Bind.singleton((i) => HomeController(usecase: i<GetNasaMediaUsecase>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
