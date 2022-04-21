import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data_access/data_access_module.dart';
import '../data_access/http_client/dio_http_client.dart';
import '../data_access/local_storage/local_storage.dart';
import 'data/datasources/home_datasource.dart';
import 'data/datasources/i_home_datasource.dart';
import 'data/repositories/home_repository.dart';
import 'domain/repositories/i_home_repository.dart';
import 'domain/usecases/get_nasa_media_usecase.dart';
import 'presentation/detail_page.dart';
import 'presentation/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        DataAccessModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.singleton<IHomeDatasource>((i) => HomeDatasource(localDb: i<LocalStorage>(), client: i<DioHttpClient>(), connectivity: Connectivity())),
        Bind.singleton<IHomeRepository>((i) => HomeRepository(datasource: i<HomeDatasource>())),
        Bind.singleton((i) => GetNasaMediaUsecase(repository: i<HomeRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage(usecase: Modular.get())),
        ChildRoute('/detail', child: (context, args) => DetailPage(media: args.data)),
      ];
}
