import 'package:gugu/core/utility/functions.dart';

abstract class MediaEntity {}

class ImageMediaEntity extends MediaEntity {
  final String path;
  final String url;

  ImageMediaEntity({
    required this.path,
    required this.url,
  });

  static Future<ImageMediaEntity> fromMap({required String path}) async {
    String url = await Functions.getDownloadableUrl(path: path);
    return new ImageMediaEntity(path: path, url: url);
  }
}
