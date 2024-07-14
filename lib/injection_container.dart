import 'package:get_it/get_it.dart';
import 'package:live_tracking_demo/utils/web_socket_service.dart';
import 'package:live_tracking_demo/viewModels/team_view_model.dart';

import 'infrastructure/apiUtil/urls.dart';
import 'infrastructure/catalog_facade_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final GetIt serviceLocator = GetIt.instance;

// register all components to get it to inject the dependencies where we need it
Future<void> init() async {
  //core
  await registerCoreComponents();

  //catalog
  registerCatalog();

  //viewModel
  registerViewModel();

  //repository
  registerRepository();

  //ApiCall
  registerApiCalls();
}

///
/// api calls
///

registerApiCalls() {
  // serviceLocator.registerLazySingleton(() => GetCoordinatesSocket(
  //       socket: serviceLocator(),
  //     ));
}

///
/// view Model
///

registerViewModel() {
  serviceLocator.registerLazySingleton(() => TeamViewModel(
        catalogFacadeService: serviceLocator(),
        webSocketService: serviceLocator(),
      ));
}

///
/// repositories
///

registerRepository() {
  // serviceLocator.registerLazySingleton(() => ArticlesRepository(
  //       articlesApi: serviceLocator(),
  //     ));
}

///
/// catalog
///

registerCatalog() {
  serviceLocator.registerLazySingleton(() => const CatalogFacadeService());
  serviceLocator.registerLazySingleton(() => WebSocketService(getNetworkObj()));
}

registerCoreComponents() {
  serviceLocator.registerLazySingleton(() => getNetworkObj());
}

io.Socket getNetworkObj() {
  io.Socket socket;
  socket = io.io(Urls.kBaseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  return socket;
}
