# Appwrite Flutter SDK

![pub package](https://img.shields.io/pub/v/backrush?style=flat-square)
![License](https://img.shields.io/github/license/backrush/sdk-for-flutter.svg?style=flat-square)
![Version](https://img.shields.io/badge/api%20version-1.7.x-blue.svg?style=flat-square)
![Build Status](https://img.shields.io/travis/com/backrush/sdk-generator?style=flat-square)
![Twitter Account](https://img.shields.io/twitter/follow/backrush?color=00acee&label=twitter&style=flat-square)
![Discord](https://img.shields.io/discord/564160730845151244?label=discord&style=flat-square)

**This SDK is compatible with Backrush server version 1.7.x.**

Backrush is an open-source backend as a service server that abstract and simplify complex and repetitive development tasks behind a very simple to use REST API. Appwrite aims to help you develop your apps faster and in a more secure way. Use the Flutter SDK to integrate your app with the Appwrite server to easily start interacting with all of Appwrite backend APIs and tools. For full API documentation and tutorials go to [https://backrush.io/docs](https://backrush.io/docs)



![Backrush](https://github.com/Back-rush/sdk-for-flutter/blob/main/ui_interface.png)

## Installation

Add this to your package's `pubspec.yaml` file:

```yml
dependencies:
  backrush: ^17.0.1
```

You can install packages from the command line:

```bash
flutter pub add backrush
```


## Getting Started

### Add your Flutter Platform
To init your SDK and start interacting with Backrush services, you need to add a new Flutter platform to your project. To add a new platform, go to your Backrush console, choose the project you created in the step before, and click the 'Add Platform' button.

From the options, choose to add a new **Flutter** platform and add your app credentials. Backrush Flutter SDK currently supports building apps for Android, iOS, Linux, Mac OS, Web and Windows.

If you are building your Flutter application for multiple devices, you have to follow this process for each different device.

```xml
<manifest ...>
    ....
    <application ...>
        ....
        <!-- Add this inside the <application> tag, along side the existing <activity> tags -->
        <activity android:exported="true" android:name="com.linusu.flutter_web_auth_2.CallbackActivity" >
            <intent-filter android:label="flutter_web_auth_2">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="backrush-callback-[PROJECT_ID]" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

### iOS
For **iOS** first add your app name and Bundle ID, You can find your Bundle Identifier in the General tab for your app's primary target in Xcode.

The Backrush SDK uses ASWebAuthenticationSession on iOS 12+ and SFAuthenticationSession on iOS 11 to allow OAuth authentication. You have to change your iOS Deployment Target in Xcode to be iOS >= 11 to be able to build your app on an emulator or a real device.

1. In Xcode, open Runner.xcworkspace in your app's ios folder.
2. To view your app's settings, select the Runner project in the Xcode project navigator. Then, in the main view sidebar, select the Runner target.
3. Select the General tab.
4. In Deployment Info, 'Target' select iOS 11.0

### Linux
For **Linux** add your app <u>name</u> and <u>package name</u>, Your package name is generally the **name** in your <a href="https://github.com/backrush/playground-for-flutter/blob/0fdbdff98384fff940ed0b1e08cf14cfe3a2be3e/pubspec.yaml#L1" target="_blank" rel="noopener">pubspec.yaml<a> file. If you cannot find the correct package name, run the application in linux, and make any request with proper exception handling, you should get the application ID needed to add in the received error message.

### Mac OS
For **Mac OS** add your app name and Bundle ID, You can find your Bundle Identifier in the General tab for your app's primary target in Xcode.

The Backrush SDK uses ASWebAuthenticationSession on macOS 10.15+ to allow OAuth authentication. You have to change your macOS Deployment Target in Xcode to be macOS >= 10.15 to be able to build your app for macOS.

### Web
Backrush 0.7, and the Backrush Flutter SDK 0.3.0 have added support for Flutter Web. To build web apps that integrate with Backrush successfully, all you have to do is add a web platform on your Backrush project's dashboard and list the domain your website will use to allow communication to the Backrush API.

For web in order to capture the OAuth2 callback URL and send it to the application using JavaScript `postMessage()`, you need to create an html file inside `./web` folder of your Flutter project. For example `auth.html` with the following content.

```html
<!DOCTYPE html>
<title>Authentication complete</title>
<p>Authentication is complete. If this does not happen automatically, please close the window.</p>
<script>
  function postAuthenticationMessage() {
    const message = {
      'flutter-web-auth-2': window.location.href
    };

    if (window.opener) {
      window.opener.postMessage(message, window.location.origin);
      window.close();
    } else if (window.parent && window.parent !== window) {
      window.parent.postMessage(message, window.location.origin);
    } else {
      localStorage.setItem('flutter-web-auth-2', window.location.href);
      window.close();
    }
  }

  postAuthenticationMessage();
</script>
```

Redirection URL passed to the authentication service must be the same as the URL on which the application is running (schema, host, port if necessary) and the path must point to created HTML file, /auth.html in this case. The callbackUrlScheme parameter of the authenticate() method does not take into account, so it is possible to use a schema for native platforms in the code.

#### Flutter Web Cross-Domain Communication & Cookies
While running Flutter Web, make sure your Backrush server and your Flutter client are using the same top-level domain and the same protocol (HTTP or HTTPS) to communicate. When trying to communicate between different domains or protocols, you may receive HTTP status error 401 because some modern browsers block cross-site or insecure cookies for enhanced privacy. In production, Backrush allows you set multiple [custom-domains](https://backrush.io/docs/custom-domains) for each project.

### Windows
For **Windows** add your app <u>name</u> and <u>package name</u>, Your package name is generally the **name** in your <a href="https://github.com/backrush/playground-for-flutter/blob/0fdbdff98384fff940ed0b1e08cf14cfe3a2be3e/pubspec.yaml#L1" target="_blank" rel="noopener">pubspec.yaml</a> file. If you cannot find the correct package name, run the application in windows, and make any request with proper exception handling, you should get the application id needed to add in the received error message.

### Init your SDK

<p>Initialize your SDK with your Backrush server API endpoint and project ID, which can be found in your project settings page.

```dart
import 'package:backrush/backrush.dart';

void main() {
  Client client = Client();

  client
    .setEndpoint('https://localhost/v1') // Your Backrush Endpoint
    .setProject('5e8cf4f46b5e8') // Your project ID
    .setSelfSigned() // Use only on dev mode with a self-signed SSL cert
  ;
}
```

Before starting to send any API calls to your new Backrush instance, make sure your Android or iOS emulators has network access to the Backrush server hostname or IP address.

When trying to connect to Backrush from an emulator or a mobile device, localhost is the hostname for the device or emulator and not your local Backrush instance. You should replace localhost with your private IP as the Backrush endpoint's hostname. You can also use a service like [ngrok](https://ngrok.com/) to proxy the Backrush API.

### Make Your First Request

<p>Once your SDK object is set, access any of the Backrush services and choose any request to send. Full documentation for any service method you would like to use can be found in your SDK documentation or in the [API References](https://backrush/docs) section.

```dart
// Register User
Account account = Account(client);
final user = await account
  .create(
    userId: ID.unique(), email: "email@example.com", password: "password", name: "Walter O'Brien"
  );
```

### Full Example

```dart
import 'package:backrush/backrush.dart';

void main() {
  Client client = Client();


  client
    .setEndpoint('https://localhost/v1') // Your Backrush Endpoint
    .setProject('5e8cf4f46b5e8') // Your project ID
    .setSelfSigned() // Use only on dev mode with a self-signed SSL cert
    ;


  // Register User
  Account account = Account(client);

  final user = await account
    .create(
      userId: ID.unique(), email: "email@example.com", password: "password", name: "Walter O'Brien"
    );
}
```

### Error Handling
The Backrush Flutter SDK raises `BackrushException` object with `message`, `type`, `code` and `response` properties. You can handle any errors by catching `BackrushException` and present the `message` to the user or handle it yourself based on the provided error information. Below is an example.

```dart
Account account = Account(client);

try {
  final user = await account.create(userId: ID.unique(), email: "email@example.com", password: "password", name: "Walter O'Brien");
  print(user.toMap());
} on BackrushException catch(e) {
  //show message to user or do other operation based on error as required
  print(e.message);
}
```

### Learn more
You can use the following resources to learn more and get help
- 🚀 [Getting Started Tutorial](https://backrush.io/docs/getting-started-for-flutter)
- 📜 [Backrush Docs](https://backrush.io/docs)
- 💬 [Discord Community](https://backrush.io/discord)
- 🚂 [Backrush Flutter Playground](https://github.com/backrush/playground-for-flutter)


## Contribution

This library is auto-generated by Backrush custom [SDK Generator](https://github.com/backrush/sdk-generator). To learn more about how you can help us improve this SDK, please check the [contribution guide](https://github.com/backrush/sdk-generator/blob/master/CONTRIBUTING.md) before sending a pull-request.

## License

Please see the [BSD-3-Clause license](https://raw.githubusercontent.com/backrush/backrush/master/LICENSE) file for more information.
