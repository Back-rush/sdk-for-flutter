import 'package:appwrite/appwrite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Project ID
    .setSelfSigned(status: true); // Enable self-signed certificates for dev

Avatars avatars = Avatars(client);

/// Downloading flag with error handling
Future<void> downloadFlag(String path) async {
  try {
    Uint8List bytes = await avatars.getFlag(
      code: Flag.afghanistan,
      width: 0, // optional
      height: 0, // optional
      quality: -1, // optional
    );

    final file = File(path);
    file.writeAsBytesSync(bytes);
    print('Flag saved to $path');
  } catch (e) {
    print('Failed to download flag: $e');
  }
}

/// Displaying flag preview with loading and error states
Widget flagPreview() {
  return FutureBuilder<Uint8List>(
    future: avatars.getFlag(
      code: Flag.afghanistan,
      width: 0, // optional
      height: 0, // optional
      quality: -1, // optional
    ), // Works for both public and private files
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error loading flag');
      } else if (snapshot.hasData) {
        return Image.memory(snapshot.data!);
      } else {
        return Text('No data available');
      }
    },
  );
}
