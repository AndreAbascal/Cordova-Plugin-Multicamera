import Foundation;

protocol ModalHandler { 
	func modalDismissed() 
}

@objc(MultiCamera) class MultiCamera: CDVPlugin, ModalHandler {
	@objc(open:)
    func open(_ command: CDVInvokedUrlCommand) {
        let cameraVC = CameraViewController();
		cameraVC.finish = {(photos: [String]) -> () in
			let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: photos);
			self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
		}
		self.viewController.present(cameraVC, animated: true, completion: nil);
    }
}