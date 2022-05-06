SCRIPT_DIR="$(dirname "$0")"
KEY_ALIAS="androiddebugkey"
PASSWORD="password"
JKS_FILE="../android/debug.jks"

cd $SCRIPT_DIR

if [ -e $JKS_FILE ]; then
    rm $JKS_FILE
fi

keytool -genkey -v -keystore $JKS_FILE -alias $KEY_ALIAS -storepass $PASSWORD -keypass $PASSWORD -keyalg RSA -validity 10000 -dname "CN=Android Debug,O=Android,C=JP"
keytool -list -v -alias $KEY_ALIAS -keystore $JKS_FILE -storepass $PASSWORD
keytool -exportcert -alias $KEY_ALIAS -storepass $PASSWORD -keystore $JKS_FILE | openssl sha1 -binary | openssl base64