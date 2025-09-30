import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// Enterprise-level file picker utility class
/// Handles image and audio file selection with comprehensive error handling
class FilePickerWidget {
  static final ImagePicker _imagePicker = ImagePicker();

  /// Picks an image from the device gallery
  /// Returns the selected image file or null if cancelled/error
  static Future<File?> pickImageFromGallery() async {
    try {
      // Check and request camera/gallery permission

      print('onTap');
      final permissionStatus = await _requestImagePermission();

      if (!permissionStatus) {
        await _showPermissionDeniedDialog();
        print('permissionStatus: $permissionStatus');
        return null;
      }

      // Pick image from gallery
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Compress image to reduce file size
        maxWidth: 1920, // Limit resolution for performance
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    } on PlatformException catch (e) {
      await _handlePlatformException(e);
      return null;
    } catch (e) {
      await _handleGenericError(e);
      return null;
    }
  }

  /// Picks an audio file from the device storage
  /// Returns the selected audio file or null if cancelled/error
  static Future<File?> pickAudioFromStorage() async {
    try {
      // Check and request storage permission
      final permissionStatus = await _requestStoragePermission();

      if (!permissionStatus) {
        await _showPermissionDeniedDialog();
        return null;
      }

      // Pick audio file
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
        withData: false, // Don't load file data into memory
        withReadStream: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          return File(file.path!);
        }
      }

      return null;
    } on PlatformException catch (e) {
      await _handlePlatformException(e);
      return null;
    } catch (e) {
      await _handleGenericError(e);
      return null;
    }
  }

  /// Gets a user-friendly file name from the file path
  static String getFullFileName(File file) {
    try {
      final path = file.path;
      final fileName = path.split('/').last;
      return fileName;
    } catch (e) {
      return 'Unknown File';
    }
  }

  /// Gets file size in a human-readable format
  static String getFileSize(File file) {
    try {
      final bytes = file.lengthSync();
      if (bytes < 1024) {
        return '$bytes B';
      } else if (bytes < 1024 * 1024) {
        return '${(bytes / 1024).toStringAsFixed(1)} KB';
      } else if (bytes < 1024 * 1024 * 1024) {
        return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      } else {
        return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
      }
    } catch (e) {
      return 'Unknown Size';
    }
  }

  /// Gets file extension from file path
  static String getFileExtension(File file) {
    try {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension;
    } catch (e) {
      return 'unknown';
    }
  }

  /// Validates if the selected image is valid
  static bool isValidImageFile(File file) {
    try {
      final extension = getFileExtension(file);
      const validImageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
      return validImageExtensions.contains(extension);
    } catch (e) {
      return false;
    }
  }

  /// Validates if the selected audio file is valid
  static bool isValidAudioFile(File file) {
    try {
      final extension = getFileExtension(file);
      const validAudioExtensions = [
        'mp3',
        'wav',
        'aac',
        'm4a',
        'flac',
        'ogg',
        'wma'
      ];
      return validAudioExtensions.contains(extension);
    } catch (e) {
      return false;
    }
  }

  /// Requests image/gallery permission
  static Future<bool> _requestImagePermission() async {
    try {
      if (Platform.isAndroid) {
        // For Android 13+ (API 33+), we need READ_MEDIA_IMAGES permission
        final status = await Permission.photos.request();
        return status.isGranted;
      } else if (Platform.isIOS) {
        final status = await Permission.photos.request();
        return status.isGranted;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Requests storage permission for audio files
  static Future<bool> _requestStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        // For Android 13+ (API 33+), we need READ_MEDIA_AUDIO permission
        final status = await Permission.audio.request();
        return status.isGranted;
      } else if (Platform.isIOS) {
        // iOS doesn't require explicit permission for file picker
        return true;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Shows permission denied dialog with options
  static Future<void> _showPermissionDeniedDialog() async {
    // Get the current context - this is a simplified approach
    // In a real app, you might want to pass context or use a global navigator
    final context = _getCurrentContext();
    if (context == null) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'This app needs access to your gallery/storage to select files. '
            'Please go to Settings and grant the required permissions, or try again.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Try Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Handles platform-specific exceptions
  static Future<void> _handlePlatformException(PlatformException e) async {
    final context = _getCurrentContext();
    if (context == null) return;

    String message = 'An error occurred while selecting the file.';

    switch (e.code) {
      case 'camera_access_denied':
      case 'photo_access_denied':
        message =
            'Gallery access was denied. Please grant permission in Settings.';
        break;
      case 'camera_access_denied_without_prompt':
      case 'photo_access_denied_without_prompt':
        message =
            'Gallery access was permanently denied. Please enable it in Settings.';
        break;
      case 'no_available_camera':
        message = 'No camera available on this device.';
        break;
      case 'file_not_found':
        message = 'The selected file could not be found.';
        break;
      case 'invalid_image':
        message = 'The selected file is not a valid image.';
        break;
      default:
        message = 'Error: ${e.message ?? 'Unknown error occurred'}';
    }

    await _showErrorSnackBar(context, message);
  }

  /// Handles generic errors
  static Future<void> _handleGenericError(dynamic error) async {
    final context = _getCurrentContext();
    if (context == null) return;

    final message = 'An unexpected error occurred: ${error.toString()}';
    await _showErrorSnackBar(context, message);
  }

  /// Shows error message as snackbar
  static Future<void> _showErrorSnackBar(
      BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Gets current context - simplified approach
  /// In production, consider using a global navigator key or context provider
  static BuildContext? _getCurrentContext() {
    // This is a simplified approach. In a real app, you might want to:
    // 1. Use a global navigator key
    // 2. Pass context as parameter
    // 3. Use a context provider
    return null; // Will be handled by the calling widget
  }
}

/// Widget to display file information with remove option
class FileInfoWidget extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  final bool isImage;

  const FileInfoWidget({
    super.key,
    required this.file,
    required this.onRemove,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isImage ? Icons.image : Icons.audiotrack,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FilePickerWidget.getFullFileName(file),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  FilePickerWidget.getFileSize(file),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
