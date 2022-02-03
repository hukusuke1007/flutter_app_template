# debug
keytool -list -v -alias androiddebugkey -keystore android/debug.keystore
keytool -exportcert -alias androiddebugkey -keystore android/debug.keystore | openssl sha1 -binary | openssl base64