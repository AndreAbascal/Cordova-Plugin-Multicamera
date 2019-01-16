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
			print("Recebi "+String(photos.count)+" foto(s).");
			let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: photos);
			for photo in photos {
				print("foto: "+photo);
			}
			print("command.callbackId: "+String(command.callbackId));
			self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
		}
		print("command.callbackId inicio: "+String(command.callbackId));
		self.viewController.present(cameraVC, animated: true, completion: nil);
        // self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        // self.viewController.present(cameraVC, animated: true, completion: nil);
    }
	func modalDismissed() { 
		print("modal dismissed.");
	} 
}