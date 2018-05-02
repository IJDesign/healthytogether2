package ch.epfl.hci.healthytogether;

import android.util.*;
import com.google.firebase.iid.*;


public class firebaseInstanceIDService extends FirebaseInstanceIdService {
    private static final String TAG = "MyActivity";


    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.d(TAG, "Refreshed token: " + refreshedToken);

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
        //sendRegistrationToServer(refreshedToken);
    }
}
