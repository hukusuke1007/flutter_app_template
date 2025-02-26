import java.io.FileInputStream
import java.util.Properties
import java.util.Base64

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Dart-Defines.
val dartEnvironmentVariables = mutableMapOf<String, String>()
if (project.hasProperty("dart-defines")) {
    val dartDefines = project.property("dart-defines").toString()
    dartDefines.split(",").forEach { entry ->
        if (entry.isNotEmpty()) {
            try {
                val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
                val separatorIndex = decoded.indexOf('=')
                if (separatorIndex > 0) {
                    val key = decoded.substring(0, separatorIndex)
                    val value = decoded.substring(separatorIndex + 1)
                    dartEnvironmentVariables[key] = value
                }
            } catch (e: Exception) {
                println("Error decoding dart-defines entry: $entry")
                println("Error: ${e.message}")
            }
        }
    }
}

// デフォルトのFLAVOR値を設定
if (!dartEnvironmentVariables.containsKey("FLAVOR")) {
    dartEnvironmentVariables["FLAVOR"] = "dev"
}

// Firebaseの設定ファイルを環境によってコピーする
tasks.register<Copy>("selectGoogleServicesJson") {
    val flavor = dartEnvironmentVariables["FLAVOR"] ?: "dev"
    from("src/$flavor/google-services.json")
    into("./")
}

tasks.whenTaskAdded {
    dependsOn("selectGoogleServicesJson")
}

// アイコン切り替えは設定してません

android {
    namespace = "com.example.app"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.app"
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // flavor設定
        val flavor = dartEnvironmentVariables["FLAVOR"] ?: "dev"
        if (flavor != "prod") {
            applicationIdSuffix = ".$flavor"
        }
        resValue("string", "app_name", (if (flavor == "prod") "" else "$flavor.") + "テンプレアプリ")
    }

    signingConfigs {
        create("release") {
            // TODO: release.jksとkey.propertiesを作成する。作成したrelease.jksのパスワード情報はkey.propertiesで管理する
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                val keystoreProperties = Properties()
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
                keyAlias = keystoreProperties["keyAlias"]?.toString() ?: ""
                keyPassword = keystoreProperties["keyPassword"]?.toString() ?: ""
                val storeFilePath = keystoreProperties["storeFile"]?.toString()
                storeFile = if (storeFilePath != null) file(storeFilePath) else null
                storePassword = keystoreProperties["storePassword"]?.toString() ?: ""
            }
        }
        getByName("debug") {
            // TODO: debug.jks作成する。作成したdebug.jksの情報に変更する。debug.jksのパスワードは以下のように設定する
            val debugStoreFile = rootProject.file("debug.jks")
            if (debugStoreFile.exists()) {
                keyAlias = "androiddebugkey"
                keyPassword = "password"
                storeFile = debugStoreFile
                storePassword = "password"
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            // https://stackoverflow.com/questions/78142862/error-execution-failed-for-task-appminifyreleasewithr8
            isMinifyEnabled = false
            isShrinkResources = false

            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
