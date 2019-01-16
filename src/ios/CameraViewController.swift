import Foundation;
import AVFoundation;

class CameraViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var activityIndicator: UIActivityIndicatorView!
    var device: AVCaptureDevice!
    var cameraPreview: PreviewView!
    var captureButton: CaptureButton!
    var output = AVCapturePhotoOutput()
    var gravity = CameraVideoGravity.resizeAspect
    var captureVideoQuality = AVCaptureSession.Preset.high
	var photos = [String]();

	public var finish: (([String]) -> ())?

	func fixOrientationOfImage(image: UIImage) -> UIImage? {
		if image.imageOrientation == .up {
			return image
		}

		// We need to calculate the proper transformation to make the image upright.
		// We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
		var transform = CGAffineTransform.identity

		switch image.imageOrientation {
		case .down, .downMirrored:
			transform = transform.translatedBy(x: image.size.width, y: image.size.height)
			transform = transform.rotated(by: CGFloat(Double.pi))
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: image.size.width, y: 0)
			transform = transform.rotated(by:  CGFloat(Double.pi / 2))
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0, y: image.size.height)
			transform = transform.rotated(by:  -CGFloat(Double.pi / 2))
		default:
			break
		}

		switch image.imageOrientation {
		case .upMirrored, .downMirrored:
			transform = transform.translatedBy(x: image.size.width, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
		case .leftMirrored, .rightMirrored:
			transform = transform.translatedBy(x: image.size.height, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
		default:
			break
		}

		// Now we draw the underlying CGImage into a new context, applying the transform
		// calculated above.
		guard let context = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue) else {
			return nil
		}

		context.concatenate(transform)

		switch image.imageOrientation {
		case .left, .leftMirrored, .right, .rightMirrored:
			context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
		default:
			context.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
		}

		// And now we just create a new UIImage from the drawing context
		guard let CGImage = context.makeImage() else {
			return nil
		}

		return UIImage(cgImage: CGImage)
	}
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.black
        cameraPreview = PreviewView(frame: UIScreen.main.bounds, session: captureSession, videoGravity: gravity)
        self.view.addSubview(cameraPreview)
        captureButton = CaptureButton(frame: UIScreen.main.bounds)
        self.view.addSubview(captureButton)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        statusAuthorize()
    }
    
    override func viewDidLoad() {
        DispatchQueue.global().async {
            self.sessionConfigure()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension CameraViewController {
    func statusAuthorize() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("authorize")
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if !(granted) {
                    self.settingDevice()
                }
            })
            break
        default:
            break
        }
    }
    
    func settingDevice() {
        DispatchQueue.main.async(execute: { [unowned self] in
            let message = NSLocalizedString("カメラを使用するためには「設定」よりカメラの使用を有効にしてください", comment: "Alert message when the user has denied access to the camera")
            let alertController = UIAlertController(title: "カメラの使用が許可されていません", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: { action in
                self.changeEnabledButton()
            }))
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: .default, handler: { action in
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        })
    }
}

extension CameraViewController {
    func sessionConfigure() {
        self.captureSession.beginConfiguration()
        self.captureSession.sessionPreset = AVCaptureSession.Preset(rawValue: self.switchVideoQuality())
        self.device = AVCaptureDevice.default(for: .video)
        let input = try! AVCaptureDeviceInput(device: self.device)
        if self.captureSession.canAddInput(input) {
            self.captureSession.addInput(input)
            print("add input")
        }
        output.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
        self.captureSession.addOutput(output)
        self.captureSession.commitConfiguration()
        self.captureSession.startRunning()
    }
    
    func switchVideoQuality() -> String {
        var qualityValue = ""
        switch captureVideoQuality {
        case AVCaptureSession.Preset.high:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.cif352x288:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.hd1280x720:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.hd1920x1080:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.hd4K3840x2160:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.iFrame1280x720:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.iFrame960x540:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.low:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.medium:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.photo:
            qualityValue = captureVideoQuality.rawValue
        case AVCaptureSession.Preset.vga640x480:
            qualityValue = captureVideoQuality.rawValue
        default:
            qualityValue = AVCaptureSession.Preset.high.rawValue
        }
        return qualityValue
    }
}

extension CameraViewController: CameraButtonDelegate, AVCapturePhotoCaptureDelegate {
    override func viewDidAppear(_ animated: Bool) {
        captureButton.delegate = self
    }

    func takePicture() {
        print("delegate");
        let settings = AVCapturePhotoSettings();
        output.capturePhoto(with: settings, delegate: self);
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		do {
			if let imageData = photo.fileDataRepresentation() {
				let tempDirectory = FileManager.default.temporaryDirectory;
				let fileName = NSUUID().uuidString;
				let fileURL = tempDirectory.appendingPathComponent(fileName+".jpg");
				var imageUIImage: UIImage = UIImage(data: imageData)!;
				imageUIImage = fixOrientationOfImage(image: imageUIImage)!;
				var imageData2: Data = UIImagePNGRepresentation(imageUIImage)!;
				try? imageData2.write(to: fileURL, options: .atomic);
				photos.append(fileURL.absoluteString);
				print("photoOutput() 1");
				if(photos.count == 3){
					print("photoOutput() 2");
					dismiss(animated: true) {
						print("photoOutput() 3");
						print("photoOutput() 4");
						self.finish?(self.photos);
					}
				}
			}else{
				print("photoOutput() erro 1");
			}
		}catch let error {
			print("error: "+error.localizedDescription);
		}
    }

    func changeEnabledButton() {
        self.captureButton.isEnabled = false
        print("button is not enable")
    }
}