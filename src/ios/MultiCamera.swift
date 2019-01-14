@objc(MultiCamera) class MultiCamera : CDVPlugin {
	@objc(open:)
	func open(command: CDVInvokedUrlCommand) {
		var pluginResult = CDVPluginResult(
			status: CDVCommandStatus_ERROR
		);
		let msg = command.arguments[0] as? String ?? ""
		if !msg.isEmpty {
			guard let unwrappedStr = msg else { return }
			let newStr = String(unwrappedStr.reversed());
			let toastController: UIAlertController = UIAlertController(title: "",message: msg,preferredStyle: .alert);
			self.viewController?.present(toastController,animated: true,completion: nil);
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				toastController.dismiss(
					animated: true,
					completion: nil
				);
			}
			pluginResult = CDVPluginResult(
				status: CDVCommandStatus_OK,
				messageAs: newStr
			);
		}
		self.commandDelegate!.send(pluginResult,callbackId: command.callbackId);
	}
}