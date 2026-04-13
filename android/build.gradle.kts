allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    val configureAndroid: (Project) -> Unit = { p ->
        if (p.extensions.findByName("android") != null) {
            val android = p.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            android.apply {
                compileSdkVersion(36)
                defaultConfig {
                    targetSdkVersion = 34
                }
                if (namespace == null) {
                    namespace = p.group.toString()
                }
            }
        }
    }

    if (project.state.executed) {
        configureAndroid(project)
    } else {
        project.afterEvaluate {
            configureAndroid(this)
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
