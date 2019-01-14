@objc(MultiCamera) class MultiCamera : CDVPlugin {
	@objc(open:)
	func open(command: CDVInvokedUrlCommand) {
		var pluginResult = CDVPluginResult(
			status: CDVCommandStatus_ERROR
		);
		let msg = command.arguments[0] as? String ?? "";
		let x = msg!;
		let reversed = String(x.reversed());
		if !msg.isEmpty {
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
				messageAs: reversed
			);
		}
		self.commandDelegate!.send(pluginResult,callbackId: command.callbackId);
	}
}