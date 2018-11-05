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

}
