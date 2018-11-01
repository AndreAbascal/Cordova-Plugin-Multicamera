/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
*/
package cordova.plugin.multicamera;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

public class MultiCamera extends CordovaPlugin {

    public static final String TAG = "MultiCamera";

    public static final int open = 1;

    private static final String ActivityName = "cordova.plugin.multicamera.CameraActivity";

    private CallbackContext callback;

    /**
     * Constructor.
     */
    public MultiCamera() {
    }

    /**
     * Sets the context of the Command. This can then be used to do things like
     * get file paths associated with the Activity.
     *
     * @param cordova The context of the main Activity.
     * @param webView The CordovaWebView Cordova is running in.
     */
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        Log.d(TAG, "Initializing MultiCamera");
    }

    /**
     * Executes the request and returns PluginResult.
     *
     * @param action            The action to execute.
     * @param args              JSONArry of arguments for the plugin.
     * @param callbackContext   The callback id used when calling back into JavaScript.
     * @return                  True if the action was valid, false if not.
     */
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        callback = callbackContext;
        if(action.equals("open")) {
            try {
                Intent intent = new Intent(ActivityName);
                // Send some info to the activity to retrieve it later
                intent.putExtra("action", MultiCamera.open);
                cordova.startActivityForResult((CordovaPlugin) this, intent, MultiCamera.open);

                PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
                result.setKeepCallback(true);
                callback.sendPluginResult(result);

                Log.d(TAG, "Open started");
            } catch(Exception ignore) {}
        } else {
            return false;   // Returning false results in a "MethodNotFound" error
        }

        return true;
    }

    /**
     * Google Pay Wrapper result
     *
     * @param requestCode
     * @param resultCode
     * @param data
     */
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        Bundle extras = data.getExtras(); //Get data sent by the Intent

        switch(requestCode) {
            case MultiCamera.open:
                if(resultCode == cordova.getActivity().RESULT_OK) {
                    boolean result = extras.getString("data").equals("true");
                    Log.d(TAG, "OpenCamera: "+result);
                    callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, result));
                } else {
                    sendError(extras.getString("data"));
				}

                return;
            default:
                // Handle other results if exists.
                super.onActivityResult(requestCode, resultCode, data);
        }
    }

    //--------------------------------------------------------------------------
    // LOCAL METHODS
    //--------------------------------------------------------------------------

    private void sendError(String error) {
        Log.w(TAG, error);
        callback.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, error));
    }
}
