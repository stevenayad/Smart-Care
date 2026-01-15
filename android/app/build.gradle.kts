import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.smartcare"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    // --- Load Google Maps API key securely from local.properties ---
    val localProperties = Properties()
    val localPropertiesFile = rootProject.file("local.properties")
    if (localPropertiesFile.exists()) {
        localPropertiesFile.inputStream().use { localProperties.load(it) }
    }
    val googleMapsApiKey = localProperties.getProperty("GOOGLE_MAPS_API_KEY") ?: ""

    defaultConfig {
        applicationId = "com.example.smartcare"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // --- Set manifest placeholder for Google Maps API key ---
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKey
    }
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true

        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )

       
        signingConfig = signingConfigs.getByName("debug")
    }
}

  lint {
        checkReleaseBuilds = false
        abortOnError = false
    }
}

flutter {
    source = "../.."
}
