import 'package:firebase_storage/firebase_storage.dart';

class Functions {
  static Future<String> getDownloadableUrl({required String path}) async {
    String url = await FirebaseStorage.instance.ref(path).getDownloadURL();
    return url;
  }
}
