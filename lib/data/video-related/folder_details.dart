import 'package:path/path.dart';

class FolderDetails {
  static Set<String> getFolders(List<String> videosList) {
    Set<String> folders = {};

    for (var folder in videosList) {

      final directory = dirname(folder);
      folders.add(directory);
    }

    return folders;
  }
}
