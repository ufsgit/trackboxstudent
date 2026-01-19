import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:aws_s3_upload_lite/enum/acl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AwsUpload {
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

      String filePath = compressedFile.path;
      FormData formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(filePath,
            filename: compressedFile.path.split('/').last),
      });

      String uploadFileName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      String uploadFilePath = 'Briffni/Students/';
      final uploadKey = uploadFilePath + uploadFileName;

      final data = await AwsS3.uploadFile(
        acl: ACL.public_read,
        accessKey: dotenv.env['AWS_ACCESS_KEY'] ?? '',
        secretKey: dotenv.env['AWS_SECRET_KEY'] ?? '',
        file: compressedFile,
        bucket: "ufsnabeelphotoalbum",
        region: "us-east-2",
        key: uploadKey,
        metadata: {"test": "test"},
        contentType: 'image/jpeg',
        destDir: uploadFilePath,
        filename: uploadFileName,
      );

      print('<<<<<<<<<<<<<<aws result>>>>>>>>>>>>>>');
      print(data.toString());

      LoaderChat.stopLoader();

      final publicUrl = '${HttpUrls.imgBaseUrl}$uploadKey';
      print('Public URL: $publicUrl');
      print('Profile URL: $uploadKey');
      return uploadKey;
    } catch (e) {
      LoaderChat.stopLoader();
      print('Error uploading to AWS: $e');
      return null;
    }
  }

  static Future<String?> uploadChatImageToAws(File selectedFile,
      String studentId, String teacherId, String fileType) async {
    // LoaderChat.showLoader();
    try {
      // Print original file size
      int originalSize = await selectedFile.length();

      // Compress the image if it's a supported type
      File fileToUpload = fileType.toLowerCase() == 'png' ||
              fileType.toLowerCase() == 'jpg' ||
              fileType.toLowerCase() == 'jpeg'
          ? await FileUtils.compressImage(selectedFile)
          : selectedFile;

      // Print compressed file size (or original size if not compressed)
      int finalSize = await fileToUpload.length();

      // String filePath = fileToUpload.path;
      // FormData formData = FormData.fromMap({
      //   "myFile": await MultipartFile.fromFile(filePath,
      //       filename: fileToUpload.path.split('/').last),
      // });

      String fileName =
          FileUtils.getFileName(selectedFile.path) + "." + fileType;
      String uploadFilePath = 'Briffni/Chat/$studentId-$teacherId/';
      final uploadKey = uploadFilePath + fileName;

      final data = await AwsS3.uploadFile(
        acl: ACL.public_read,
        accessKey: dotenv.env['AWS_ACCESS_KEY'] ?? '',
        secretKey: dotenv.env['AWS_SECRET_KEY'] ?? '',
        file: fileToUpload,
        bucket: "ufsnabeelphotoalbum",
        region: "us-east-2",
        key: uploadKey,
        metadata: {"test": "test"},
        destDir: uploadFilePath,
        filename: fileToUpload.path.split('/').last,
      );

      // LoaderChat.stopLoader();

      final publicUrl = '${HttpUrls.imgBaseUrl}$uploadKey';

      return uploadKey;
    } catch (e) {
      LoaderChat.stopLoader();
      print('Error uploading to AWS: $e');
      return null;
    }
  }

  static Future<FormData?> prepareFormData(File result) async {
    try {
      String filePath = result.path;
      FormData formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(filePath,
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
