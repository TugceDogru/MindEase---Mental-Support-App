pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localProperties = file("local.properties")
        if (!localProperties.exists()) {
            throw GradleException("Missing local.properties file in android/ directory.")
        }
        localProperties.inputStream().use { properties.load(it) }
        properties.getProperty("flutter.sdk") ?: throw GradleException("flutter.sdk not set in local.properties")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "mind_ease"

include(":app")
