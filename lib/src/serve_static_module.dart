import 'package:serinus/serinus.dart';

import 'serve_static_controller.dart';

/// This module is a representation of the entrypoint of your plugin.
/// It is the main class that will be used to register your plugin with the application.
/// 
/// This module should extend the [Module] class and override the [registerAsync] method.
/// 
/// You can also use the constructor to initialize any dependencies that your plugin may have.
class ServeStaticModule extends Module {

  final ServeStaticModuleOptions? options;
  final List<Guard> userDefinedGuards;
  
  ServeStaticModule({
    this.userDefinedGuards = const [],
    this.options
  }) : super(options: options);

  @override
  List<Guard> get guards => userDefinedGuards;

  @override
  Future<Module> registerAsync() async {
    final moduleOptions = options ?? ServeStaticModuleOptions();
    final serveStaticController = ServeStaticController(
      path: moduleOptions.path,
      extensionsBlacklist: moduleOptions.extensionsBlacklist
    );
    controllers.add(serveStaticController);
    return this;
  }

}

class ServeStaticModuleOptions extends ModuleOptions{

  final String path;

  final List<String> extensionsBlacklist;

  ServeStaticModuleOptions({
    this.path = '/public',
    this.extensionsBlacklist = const []
  });

}