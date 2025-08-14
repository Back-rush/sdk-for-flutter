import 'package:appwrite/appwrite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Project ID
    .setSelfSigned(status: true); // Enable self-signed certificates for dev

Avatars avatars = Avatars(client);

/// Downloading file with improved error handling
Future<void> downloadAvatar(String path) async {
  try {
    Uint8List bytes = await avatars.getBrowser(
      code: Browser.avantBrowser,
      width: 0, // optional
      height: 0, // optional
      quality: -1, // optional
    );

    final file = File(path);
    file.writeAsBytesSync(bytes);
    print('Avatar saved to $path');
  } catch (e) {
    print('Failed to download avatar: $e');
  }
}

/// Displaying image preview with loading indicator
Widget avatarPreview() {
  return FutureBuilder<Uint8List>(
    future: avatars.getBrowser(
      code: Browser.avantBrowser,
      width: 0, // optional
      height: 0, // optional
      quality: -1, // optional
    ), // Works for b
