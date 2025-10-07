import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

Future<File?> pickImageFromStorage() async {
  try {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    if (image != null) {
      return File(image.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    print("Error picking image from storage: $e");
    return null;
  }
}

Future<File?> pickAudioFromStorage({
  List<String> allowedExtensions = const ["mp3", "wav", "aac", "m4a"],
  bool allowMultiple = false,
}) async {
  try {
    // Start picking audio files
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: allowMultiple,
      withData: false, // Prevents memory overhead
    );

    // If user cancels the picker
    if (result == null || result.files.isEmpty) {
      print("[AudioPicker] User canceled the selection.");
      return null;
    }

    // Take the first selected file (or handle multiple if needed)
    final pickedFile = result.files.first;

    // Validate file path
    if (pickedFile.path == null || pickedFile.path!.isEmpty) {
      print("[AudioPicker] Invalid file path received.");
      return null;
    }

    final file = File(pickedFile.path!);

    // Validate file existence
    if (!file.existsSync()) {
      print("[AudioPicker] File does not exist at path: ${file.path}");
      return null;
    }

    // Validate extension
    final extension = file.path.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      print("[AudioPicker] Unsupported audio format: .$extension");
      return null;
    }

    // ✅ Success
    print("[AudioPicker] File picked successfully: ${file.path}");
    print("[AudioPicker] Size: ${file.lengthSync()} bytes");
    return file;
  } on FileSystemException catch (e) {
    print("[AudioPicker][FileSystemException] ${e.message}");
    return null;
  } on PlatformException catch (e) {
    print(
        "[AudioPicker][PlatformException] Code: ${e.code}, Message: ${e.message}");
    return null;
  } catch (e, stack) {
    print("[AudioPicker][UnknownError] $e");
    print(stack);
    return null;
  }
}
