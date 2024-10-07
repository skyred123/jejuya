import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

/// File type enum
enum FileType {
  /// Asset file type
  asset,

  /// Local file type
  local,

  /// Remote file type
  remote,
}

/// The different types of media that can be stored in the table.
enum MediaType {
  /// An image file.
  image,

  /// A video file.
  video,

  /// An audio file.
  audio,

  /// A document file.
  document,

  /// A lottie file.
  lottie,

  /// Any other type of file.
  other,
}

/// Media type enum
extension FilePathMediaType on String {
  /// Returns the media type of the file.
  MediaType get mediaType {
    // First, try MIME type
    final mimeType = lookupMimeType(this);
    if (mimeType != null) {
      if (mimeType.startsWith('image/')) return MediaType.image;
      if (mimeType.startsWith('audio/')) return MediaType.audio;
      if (mimeType.startsWith('video/')) return MediaType.video;
      if (mimeType.startsWith('lottie/')) return MediaType.lottie;
    }

    // If MIME type doesn't work, try file extension
    final extension = path.extension(this).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.svg':
      case '.gif':
        return MediaType.image;
      case '.mp3':
      case '.wav':
      case '.aac':
        return MediaType.audio;
      case '.mp4':
      case '.avi':
      case '.mov':
        return MediaType.video;
      case '.json':
        return MediaType.lottie;
    }

    return MediaType.other;
  }

  /// Returns the file type of the file.
  FileType get fileType {
    if (startsWith('assets/')) return FileType.asset;
    if (startsWith('http://') || startsWith('https://')) return FileType.remote;
    return FileType.local;
  }
}
