import Foundation;

protocol ModalHandler { 
	func modalDismissed() 
}

@objc(MultiCamera) class MultiCamera: CDVPlugin, ModalHandler {
	@objc(open:)
    func open(_ command: CDVInvokedUrlCommand) {
        let cameraVC = CameraViewController();
		cameraVC.finish = {(photos: [String]) -> () in
			print("Chegou aqui");
			print("Recebi "+photos.count+" foto(s).");
			let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: photos);
			for photo in photos {
				println("foto: "+photo);
			}
			self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        	self.viewController.present(cameraVC, animated: true, completion: nil);
		}
        // self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        // self.viewController.present(cameraVC, animated: true, completion: nil);
    }
	func modalDismissed() { 
		print("modal dismissed.");
	} 
}