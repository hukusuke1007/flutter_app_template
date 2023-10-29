# debug
keytool -list -v -alias androiddebugkey -keystore android/debug.jks
keytool -exportcert -alias androiddebugkey -keystore android/debug.jks | openssl sha1 -binary | openssl base64