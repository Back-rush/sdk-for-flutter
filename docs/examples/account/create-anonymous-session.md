import 'package:appwrite/appwrite.dart';

/// Initialize Appwrite client
Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Project ID
    .setSelfSigned(status: true); // Enable self-signed certificates for dev

/// Initialize account service
Account account = Account(client);

/// Create an anonymous session with error handling
Future<void> createSession() async {
  try {
    Session result = await account.createAnonymousSession();
    print('Anonymous session created: ${result.$id}');
  } catch (e) {
    print('Failed to create session: $e');
  }
}

/// Optional: Log out function
Future<void> logout() async {
  try {
    await account.deleteSession(sessionId: 'current');
    print('Logged out successfully');
  } catch (e) {
    print('Logout failed: $e');
  }
}
