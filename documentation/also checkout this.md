# Qr Boss


## Getting started


#### 1. [Setup Flutter](https://flutter.io/setup/)



#### 2. Setup the firebase app

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you'll need to enable anonymous authentication.

* Go to the Firebase Console for your new instance.
* Go to the Firebase Console
* Click the Cloudstore "Create Database" button
* Select "Start in test mode" and "Enable" or " set up your own rules " if you need help buy a support package

* Create an app within your Firebase instance for Android, with package name com.sidtube.qr
* Run the following command on your pc to get your SHA-1 key:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

* Follow instructions to download google-services.json
* place `google-services.json` into `/android/app/`.




Double check install instructions 

   - Firestore Plugin
     -  https://pub.dartlang.org/packages/cloud_firestore

#### 3. Build flutter appbundle 

To build appbundle for playstore 



 ```
 flutter build appbundle

```

