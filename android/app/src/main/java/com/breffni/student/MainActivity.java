package com.trackbox.student;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import android.app.AppOpsManager;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle; // Import for Bundle
import android.os.PowerManager;
import android.provider.Settings;
import android.util.Log;
import android.view.WindowManager;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.Objects;


// by riyas 29/nov/ 2024
// Changed FlutterActivity to FlutterFragmentActivity because the HyperSDKFlutter plugin
// requires FlutterFragmentActivity to work properly.

// When switching to FlutterFragmentActivity, some context-related features were missing.
// To address this, the dependency 'androidx.fragment:fragment:1.8.5' was added to the
// app's Gradle configuration to ensure proper functionality of AndroidX Fragment features.

// The method `configureFlutterEngine()` is called when the Flutter engine is initialized.
// It is now used to set up MethodChannels or other native integrations as
// `onCreate()` no longer provides the same context behavior in FlutterFragmentActivity.

public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "methodChannel";
    private static final int FULL_SCREEN_INTENT_REQUEST_CODE = 1001;
    private MethodChannel.Result pendingResult;
    private final ActivityResultLauncher<Intent> fullScreenIntentLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (pendingResult != null) {
                    // Check if permission was granted after returning from settings
                    pendingResult.success(isFullScreenIntentAllowed());
                    pendingResult = null;
                }
            }
    );

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        // Set the FLAG_SECURE to prevent screenshots and screen recordings
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE);

        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        new MethodChannel.MethodCallHandler() {
                            @Override
                            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

                                if (call.method.equals("initFirebaseCleanup")) {
//                                FirebaseFirestore.getInstance().collection("calls")
//                                        .document("STD-" + 9)
//                                        .delete()
//                                        .addOnSuccessListener(new OnSuccessListener<Void>() {
//                                            @Override
//                                            public void onSuccess(Void aVoid) {
//                                                Log.d("Firestore", "Document deleted for student: " + 9);
//                                            }
//                                        })
//                                        .addOnFailureListener(new OnFailureListener() {
//                                            @Override
//                                            public void onFailure(@NonNull Exception e) {
//                                                Log.w("Firestore", "Failed to delete document for student: " + 9, e);
//                                            }
//                                        });
//                                // Start service with student ID
//                                Intent serviceIntent = new Intent(MainActivity.this, FirebaseCleanUpService.class);
//                                serviceIntent.putExtra(FirebaseCleanUpService.EXTRA_STUDENT_ID, "9");
//                                startService(serviceIntent);

                                    result.success(null);
                                }else if (call.method.equals("wakeScreen")) {
                                    wakeScreen();
                                    result.success(null);
                                }else  if (call.method.equals("requestBatteryOptimization")) {
                                    pendingResult = result;
                                    requestBatteryOptimization();

                                }else  if (call.method.equals("requestFullScreenIntentPermission")) {
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                                        pendingResult = result;
                                        requestFullScreenIntentPermission();
                                    }else{
                                        result.success(true);


                                    }

                            } else {
                                result.notImplemented();
                            }
                        }
                    }
                );

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);




    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
//        Intent serviceIntent = new Intent(this, FirebaseCleanUpService.class);
//        startService(serviceIntent);
    }

    private boolean isFullScreenIntentAllowed() {
        // Pre-Android 10, full-screen intents are always allowed
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            return true;
        }

        // For Android 10 and above
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            try {
                NotificationManager notificationManager =
                        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

                // Check if the app is allowed to use full-screen intents
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                    return notificationManager.canUseFullScreenIntent();
                }
            } catch (Exception e) {
                return false;
            }
        }

        return false;
    }
    /**
     * Requests permission for full-screen intents
     */
    @RequiresApi(api = Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private void requestFullScreenIntentPermission() {
        // Only relevant for Android 10 and above
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            pendingResult.success(true);

            return;
        }

        if (!isFullScreenIntentAllowed()) {
            Intent intent = new Intent(
                    Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT,
                    Uri.parse("package:" + getPackageName())
            );
            fullScreenIntentLauncher.launch(intent);

//            startActivityForResult(intent, FULL_SCREEN_INTENT_REQUEST_CODE);
        }else{
            pendingResult.success(true);

        }
    }
    private void wakeScreen() {
        PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
        PowerManager.WakeLock wakeLock = powerManager.newWakeLock(
                PowerManager.SCREEN_BRIGHT_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP,
                "MyApp::WakelockTag");

        wakeLock.acquire(3000); // Wake the screen for 3 seconds
        wakeLock.release();
    }
    private void requestBatteryOptimization() {
        if(isBatteryOptimizationEnabled()) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                String packageName = getPackageName();
                PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);

                if (!pm.isIgnoringBatteryOptimizations(packageName)) {
                    try {
                        Intent intent = new Intent();
                        intent.setAction(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
                        intent.setData(Uri.parse("package:" + packageName));
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        pendingResult.success(true);

                    } catch (Exception e) {
                        e.printStackTrace();
                        pendingResult.success(false);
                    }
                }else{
                    pendingResult.success(true);

                }
            }else{
                pendingResult.success(true);

            }
        }else{
            pendingResult.success(true);

        }
    }

    private boolean isBatteryOptimizationEnabled() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            String packageName = getPackageName();
            PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);
            boolean ss=!pm.isIgnoringBatteryOptimizations(packageName);
            return ss;
        }
        return false;
    }

}
