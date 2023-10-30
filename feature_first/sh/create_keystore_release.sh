SCRIPT_DIR="$(dirname "$0")"
KEY_ALIAS="key"
# ランダムに生成された16桁のパスワード
PASSWORD="$(openssl rand -base64 12 | fold -w 16 | head -1)"
JKS_FILE="../android/release.jks"
PROPERTIES_FILE="../android/key.properties"

cd $SCRIPT_DIR

if [ -e $PROPERTIES_FILE ]; then
    rm $PROPERTIES_FILE
fi

if [ -e $JKS_FILE ]; then
    rm $JKS_FILE
fi

keytool -genkey -v -keystore $JKS_FILE -alias $KEY_ALIAS -storepass $PASSWORD -keypass $PASSWORD -keyalg RSA -keysize 2048 -validity 10000 -dname "C=JP"
keytool -list -v -keystore $JKS_FILE -storepass $PASSWORD
keytool -exportcert -alias $KEY_ALIAS -storepass $PASSWORD -keystore $JKS_FILE | openssl sha1 -binary | openssl base64

# android/key.propertiesのファイルの中身を空にする
touch $PROPERTIES_FILE
: > $PROPERTIES_FILE
echo "storePassword=$PASSWORD" >> $PROPERTIES_FILE
echo "keyPassword=$PASSWORD" >> $PROPERTIES_FILE
echo "keyAlias=$KEY_ALIAS" >> $PROPERTIES_FILE
echo "storeFile=../release.jks" >> $PROPERTIES_FILE