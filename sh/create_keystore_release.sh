# release
keytool -genkey -v -keystore android/release.jks -alias alias_name -keyalg RSA -validity 10000
keytool -list -v -keystore android/release.jks
keytool -exportcert -alias alias_name -keystore android/release.jks | openssl sha1 -binary | openssl base64