package com.trackbox.student;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.FirebaseFirestore;

public class FirebaseCleanUpService extends Service {

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // Call the Firestore delete method here
        deleteFirestoreDocument();

        // Stop service after the task is complete if it's a one-time operation
        stopSelf();
        return START_NOT_STICKY; // Service won't restart automatically if killed
    }

    private void deleteFirestoreDocument() {
        FirebaseFirestore.getInstance().collection("calls")
                .document("STD-9")
                .delete()
                .addOnSuccessListener(aVoid -> Log.d("Firestore", "Document deleted for student: " + 9))
                .addOnFailureListener(e -> Log.w("Firestore", "Failed to delete document for student: " + 9, e));
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null; // Return null as it's not a bound service
    }
}
