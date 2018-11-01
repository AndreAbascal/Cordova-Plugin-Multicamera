/**
 * This is a template for new plugin wrappers
 *
 * TODO:
 * - Add/Change information below
 * - Document usage (importing, executing main functionality)
 * - Remove any imports that you are not using
 * - Remove all the comments included in this template, EXCEPT the @Plugin wrapper docs and any other docs you added
 * - Remove this note
 *
 */
import { Injectable } from '@angular/core';
import { Cordova, IonicNativePlugin, Plugin } from '@ionic-native/core';
import { Observable } from 'rxjs/Observable';

/**
 * @name @ionic-native/ Multi Camera
 * @description
 * This plugin does something
 *
 * @usage
 * ```typescript
 * import { MultiCamera } from '@ionic-native/ionic-native-multi-camera';
 *
 *
 * constructor(private multiCamera: MultiCamera) { }
 *
 * ...
 *
 *
 * this.MultiCamera.functionName('Hello', 123)
 *   .then((res: any) => console.log(res))
 *   .catch((error: any) => console.error(error));
 *
 * ```
 */
@Plugin({
  pluginName: 'MultiCamera',
  plugin: '', // npm package name, example: cordova-plugin-camera
  pluginRef: '', // the variable reference to call the plugin, example: navigator.geolocation
  repo: '', // the github repository URL for the plugin
  install: '', // OPTIONAL install command, in case the plugin requires variables
  installVariables: [], // OPTIONAL the plugin requires variables
  platforms: [] // Array of platforms supported, example: ['Android', 'iOS']
})
@Injectable()
export class MultiCamera extends IonicNativePlugin {

  /**
   * open 7camera
   * @return {Promise<any>} Returns a promise that resolves when something happens
   */
  @Cordova({  callbackOrder: 'reverse' })
  open(options: any): Promise<any> {
    return; // We add return; here to avoid any IDE / Compiler errors
  }

}
