import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'messageHelper.dart';

// To save the file in the device
class FileStorageHelper {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeToExcel(List<int> bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    File file = File('$path/$name');

    // Write the data in the file you have created
    await file.writeAsBytes(bytes);

    return file;
  }

  static Future<File?> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    return result?.files.single.path != null
        ? File(result!.files.single.path!)
        : null;
  }

  static Future<Uint8List?> pickAndReadExcelFile() async {
    try {
      // Pick the Excel file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        // Get the file path
        String filePath = result.files.first.path!;

        // Read file bytes
        Uint8List? bytes = await _readFileBytes(filePath);
        return bytes;
      } else {
        // If no file was picked, show an error message or handle it accordingly
        showLog('Error: No file picked');
        return null;
      }
    } catch (e) {
      // Catch any exceptions that occur during file picking
      showLog('Error picking or reading Excel file: $e');
      return null;
    }
  }

  static Future<Uint8List?> _readFileBytes(String filePath) async {
    try {
      // Open the file
      File file = File(filePath);

      // Read the file bytes
      Uint8List bytes = await file.readAsBytes();

      return bytes;
    } catch (e) {
      // Catch any exceptions that occur during file reading
      showLog('Error reading file bytes: $e');
      return null;
    }
  }
}
