import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:minio/minio.dart';
import 'package:dio/dio.dart' as dio;

class AwsUpload {
  static final Minio minio = Minio(
    endPoint: dotenv.env['CLOUDFLARE_R2_ENDPOINT'] ?? '',
    accessKey: dotenv.env['CLOUDFLARE_R2_ACCESS_KEY_ID'] ?? '',
    secretKey: dotenv.env['CLOUDFLARE_R2_SECRET_ACCESS_KEY'] ?? '',
    useSSL: true,
  );

  static final String bucket =
      dotenv.env['CLOUDFLARE_R2_BUCKET_NAME'] ?? 'trackbox';

  static Future<String?> uploadToAws(File result) async {
    LoaderChat.showLoader();
    try {
      // Print original file size
      int originalSize = await result.length();
      print('Original file size: ${_formatFileSize(originalSize)}');

      // Compress the image
      File compressedFile = await FileUtils.compressImage(result);

      // Print compressed file size
      int compressedSize = await compressedFile.length();
      print('Compressed file size: ${_formatFileSize(compressedSize)}');

      String uploadFileName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      String uploadFilePath = 'Briffni/Students/';
      final uploadKey = uploadFilePath + uploadFileName;

      // Upload using Minio
      await minio.putObject(
        bucket,
        uploadKey,
        compressedFile.openRead().cast<Uint8List>(),
        size: compressedSize,
        metadata: {'Content-Type': 'image/jpeg'},
      );

      print('<<<<<<<<<<<<<<Cloudflare R2 result: Success>>>>>>>>>>>>>>');

      LoaderChat.stopLoader();

      final publicUrl = '${HttpUrls.imgBaseUrl}$uploadKey';
      print('Public URL: $publicUrl');
      print('Profile URL: $uploadKey');
      return uploadKey;
    } catch (e) {
      LoaderChat.stopLoader();
      print('Error uploading to Cloudflare R2: $e');
      return null;
    }
  }

  static Future<String?> uploadChatImageToAws(File selectedFile,
      String studentId, String teacherId, String fileType) async {
    try {
      // Compress the image if it's a supported type
      File fileToUpload = fileType.toLowerCase() == 'png' ||
              fileType.toLowerCase() == 'jpg' ||
              fileType.toLowerCase() == 'jpeg'
          ? await FileUtils.compressImage(selectedFile)
          : selectedFile;

      int finalSize = await fileToUpload.length();

      String fileName =
          FileUtils.getFileName(selectedFile.path) + "." + fileType;
      String uploadFilePath = 'Briffni/Chat/$studentId-$teacherId/';
      final uploadKey = uploadFilePath + fileName;

      // Upload using Minio
      await minio.putObject(
        bucket,
        uploadKey,
        fileToUpload.openRead().cast<Uint8List>(),
        size: finalSize,
        metadata: {'Content-Type': _getContentType(fileType)},
      );

      return uploadKey;
    } catch (e) {
      print('Error uploading chat image to Cloudflare R2: $e');
      return null;
    }
  }

  static String _getContentType(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  static Future<dio.FormData?> prepareFormData(File result) async {
    try {
      String filePath = result.path;
      dio.FormData formData = dio.FormData.fromMap({
        "myFile": await dio.MultipartFile.fromFile(filePath,
            filename: result.path.split('/').last),
      });

      print('FormData prepared: ${formData.files}');
      return formData;
    } catch (e) {
      print('Error preparing FormData: $e');
      return null;
    }
  }

  static String _formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
  }
}
