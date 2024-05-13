import 'dart:convert';
import 'dart:io';
import 'package:serinus/serinus.dart';

class ServeRouteGet extends Route {
  const ServeRouteGet({super.path = '/*', super.method = HttpMethod.get});
}

class ServeStaticController extends Controller {
  final List<String> extensionsBlacklist;

  ServeStaticController({
    required super.path,
    this.extensionsBlacklist = const [],
  }) {
    on(ServeRouteGet(), (context) async {
      final path = context.request.path;
      if(extensionsBlacklist.isNotEmpty){
        for(var extension in extensionsBlacklist){
          if(path.endsWith(extension)){
            throw ForbiddenException(message: 'The files with extension $extension are not allowed to be served');
          }
        }
      }
      Directory current = Directory.current;
      final file = File('${current.path}/$path');
      if (!file.existsSync()) {
        throw NotFoundException(message: 'The file $path does not exist');
      }
      return Response.text(utf8.decode(file.readAsBytesSync()));
    });
  }
}