# debug
keytool -genkey -v -keystore android/debug.keystore -alias androiddebugkey -keyalg RSA -validity 10000 -dname "CN=Android Debug,O=Android,C=JA"
keytool -list -v -alias androiddebugkey -keystore android/debug.keystore
keytool -exportcert -alias androiddebugkey -keystore android/debug.keystore | openssl sha1 -binary | openssl base64