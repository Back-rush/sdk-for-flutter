import 'package:appwrite/appwrite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Project ID
    .setSelfSigned(status: true); // Enable self-signed certificates for dev

Avatars avatars = Avatars(client);

/// Downloading initials avatar with error handling
Future<void> downloadInitialsAvatar(String path, String name) async {
  try {
    Uint8List bytes = await avatars.getInitials(
      name: name, // optional
      width: 128, // default size set
      height: 128, // default size set
      background: '#CCCCCC', // default background color
    );

    final file = File(path);
    file.writeAsBytesSync(bytes);
    print('Initials avatar saved to $path');
  } catch (e) {
    print('Failed to download initials avatar: $e');
  }
}

/// Displaying initials avatar preview with loading and error states
Widget initialsAvatarPreview(String name) {
  return FutureBuilder<Uint8List>(
    future: avatars.getInitials(
      name: name, // optional
      width: 128,
      height: 128,
      background: '#CCCCCC',
    ),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error loading initials avatar');
      } else if (snapshot.hasData) {
        return Image.memory(snapshot.data!);
      } else {
        return Text('No data available');
      }
    },
  );
}
