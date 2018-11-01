import { IonicNativePlugin } from '@ionic-native/core';
/**
 * @name MultiCamera
 * @description
 * This plugin does something
 *
 * @usage
 * ```typescript
 * import { MultiCamera } from 'Multi-camera';
 *
 *
 * constructor(private multiCamera: MultiCamera) { }
 *
 * ...
 *
 *
 * this.multiCamera.functionName('Hello', 123)
 *   .then((res: any) => console.log(res))
 *   .catch((error: any) => console.error(error));
 *
 * ```
 */
export declare class MultiCamera extends IonicNativePlugin {
    /**
     * Open 7camera
     * @return {Promise<any>} Returns a promise that resolves when something happens
     */
    open(options: any): Promise<any>;
}
