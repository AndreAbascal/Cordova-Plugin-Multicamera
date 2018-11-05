/*
 * Copyright 2017 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cordova.plugin.multicamera;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.content.Intent;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class CameraActivity extends AppCompatActivity {
	public static final String TAG = "MultiCamera";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
		Log.d(TAG,"CameraActivity onCreate");
        super.onCreate(savedInstanceState);
		Log.d(TAG,"CameraActivity 2");
        // setContentView(R.layout.activity_camera);
		setContentView(CameraActivity.this.getResources().getIdentifier("activity_camera", "layout", CameraActivity.this.getPackageName()));
		Log.d(TAG,"CameraActivity 3");
        if (null == savedInstanceState) {
			Log.d(TAG,"CameraActivity 4");
            // getSupportFragmentManager().beginTransaction().replace(R.id.container, Camera2BasicFragment.newInstance()).commit();
			getSupportFragmentManager().beginTransaction().replace(CameraActivity.this.getResources().getIdentifier("container", "id", CameraActivity.this.getPackageName()), Camera2BasicFragment.newInstance()).commit();
        }else{
			Log.d(TAG,"CameraActivity 5");
		}
    }
	@Override
	public void onStart(){
		Log.d(TAG,"CameraActivity onStart");
		super.onStart();
		Log.d(TAG,"CameraActivity onStart 2");
        Bundle extras = getIntent().getExtras();
		Log.d(TAG,"CameraActivity onStart 3");
        if (extras == null) {
            Log.d(TAG, "onStart without action");
            sendActivityResult(9, "called without action");
        } else {
			Log.d(TAG,"CameraActivity onStart 4");
            for (String key : extras.keySet()) {
                Object value = extras.get(key);
                Log.d(TAG, " onStartBundle extras -> "+String.format("%s %s (%s)", key,
                        value.toString(), value.getClass().getName()));
            }
			Log.d(TAG,"CameraActivity onStart 5");
        }
	}
	@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
		Log.d(TAG,"CameraActivity onActivityResult");
		Log.d(TAG,"CameraActivity requestCode: "+requestCode);
		Log.d(TAG,"CameraActivity resultCode: "+resultCode);
		Bundle extras = data.getExtras();
		Log.d(TAG,"CameraActivity onActivityResult 2");
		for (String key : extras.keySet()) {
			Object value = extras.get(key);
			Log.d(TAG, "onActivityResult Bundle extras -> "+String.format("%s %s (%s)", key,value.toString(), value.getClass().getName()));
		}
		Log.d(TAG,"CameraActivity onActivityResult 3");
	}

	private void sendActivityResult(int resultCode, String response) {
		Log.d(TAG,"CameraActivity sendActivityResult... resultCode: "+resultCode);
		Log.d(TAG,"CameraActivity sendActivityResult... response: "+response);
        Intent intent = new Intent();
        intent.putExtra("data", response);
        setResult(resultCode, intent);
        finish();// Exit of this activity !
    }

    private void sendActivityResultJSON(int resultCode,JSONObject response) {
		Log.d(TAG,"CameraActivity sendActivityResultJSON... resultCode: "+resultCode);
		Log.d(TAG,"CameraActivity sendActivityResultJSON... response: "+response.toString());
        Intent intent = new Intent();
        intent.putExtra("data", response.toString());
        setResult(resultCode, intent);
        finish();// Exit of this activity !
    }

}
