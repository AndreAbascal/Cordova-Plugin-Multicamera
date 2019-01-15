import Foundation
@objc(MultiCamera) class MultiCamera: CDVPlugin {
    func startcamera(_ command: CDVInvokedUrlCommand) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "message");
        let cameraVC = CameraViewController();
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        self.viewController.present(cameraVC, animated: true, completion: nil);
    }
}