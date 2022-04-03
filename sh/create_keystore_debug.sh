# debug
keytool -genkey -v -keystore android/debug.jks -alias androiddebugkey -keyalg RSA -validity 10000 -dname "CN=Android Debug,O=Android,C=JA"
keytool -list -v -alias androiddebugkey -keystore android/debug.jks
keytool -exportcert -alias androiddebugkey -keystore android/debug.jks | openssl sha1 -binary | openssl base64