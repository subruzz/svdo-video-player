import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class TrimVideo {
  static Future<String?> createExternalFolder() async {
    try {
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        String externalPath = externalDir.path;
        String folderName = 'trimmedVideos';
        String folderPath = '$externalPath/$folderName';
        if (!await Directory(folderPath).exists()) {
          await Directory(folderPath).create(recursive: true);
        }

        return folderPath;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  static Future<bool> addVideo(File file, String name) async {
    try {
      String? folderPath = await createExternalFolder();
      String videoName = '$name${p.extension(file.path)}';
      String videoPath = '$folderPath/$videoName';

      // Check if the file already exists
      File destinationFile = File(videoPath);
      if (await destinationFile.exists()) {
        return true; // Exit the function
      } else {
        await file.copy(videoPath);
        return false;
      }
    } catch (err) {
      return true;
    }
  }
}
