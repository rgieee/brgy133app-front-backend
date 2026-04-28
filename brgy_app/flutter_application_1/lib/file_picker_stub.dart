// Minimal local stub for `file_picker` used during builds when plugin
// compilation fails. This provides just enough API surface for the app's
// feedback file picker usage. Replace with the real package in production.

class PlatformFile {
  final String name;
  PlatformFile({required this.name});
}

class FilePickerResult {
  final List<PlatformFile> files;
  FilePickerResult(this.files);
}

enum FileType { any }

class _FilePickerPlatform {
  Future<FilePickerResult?> pickFiles({
    FileType? type,
    bool allowMultiple = false,
  }) async {
    // Return null to indicate no file picked.
    return null;
  }
}

class FilePicker {
  static final platform = _FilePickerPlatform();
}
