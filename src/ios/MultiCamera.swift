import Foundation;

protocol ModalHandler { 
	func modalDismissed() 
}

@objc(MultiCamera) class MultiCamera: CDVPlugin, ModalHandler {
	func buceta(){
		print("Bucetao");
	}
	@objc(open:)
    func open(_ command: CDVInvokedUrlCommand) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "message");
        let cameraVC = CameraViewController();
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        self.viewController.present(cameraVC, animated: true, completion: nil);
    }
	func modalDismissed() { 
		print("modal dismissed.");
	} 
}