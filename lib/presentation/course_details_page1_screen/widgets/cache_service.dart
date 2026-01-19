import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();

  factory CacheService() => _instance;

  CacheService._internal();

  Future<String> getCachedFilePath(String url) async {
    final fileName = md5.convert(utf8.encode(url)).toString();
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  Future<bool> isFileCached(String url) async {
    try {
      final filePath = await getCachedFilePath(url);
      final file = File(filePath);
      if (await file.exists()) {
        // Check if file is not empty
        final fileStats = await file.stat();
        return fileStats.size > 0;
      }
      return false;
    } catch (e) {
      debugPrint('Error checking cached file: $e');
      return false;
    }
  }

  Future<String> getCachedFile(String url) async {
    try {
      final filePath = await getCachedFilePath(url);

      // Check if file is already cached
      if (await isFileCached(url)) {
        debugPrint('Returning cached file: $filePath');
        return filePath;
      }

      // Download and cache if not exists
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        debugPrint('File cached successfully: $filePath');
        return filePath;
      } else {
        throw HttpException(
            'Failed to download file: Status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error caching file: $e');
      return url; // Return original URL if caching fails
    }
  }

  Future<void> clearCache() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(directory.path);

      if (await cacheDir.exists()) {
        await for (var entity in cacheDir.list()) {
          if (entity is File) {
            await entity.delete();
          }
        }
      }
      debugPrint('Cache cleared successfully');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  Future<int> getCacheSize() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(directory.path);

      if (await cacheDir.exists()) {
        int totalSize = 0;
        await for (var entity in cacheDir.list()) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
        return totalSize;
      }
      return 0;
    } catch (e) {
      debugPrint('Error getting cache size: $e');
      return 0;
    }
  }
}
