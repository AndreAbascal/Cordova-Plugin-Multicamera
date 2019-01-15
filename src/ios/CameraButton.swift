import Foundation;

protocol CameraButtonDelegate {
    func takePicture()
    func changeEnabledButton()
}

class CaptureButton: UIButton {
    var delegate: CameraButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.center = CGPoint(x: frame.width / 1.12, y: frame.height / (3/4));
        self.frame.size = CGSize(width: 80, height: 80);
        self.backgroundColor = UIColor.white;
        self.layer.cornerRadius = self.frame.width / 2;
        self.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside);
    }
    
    @objc func tappedButton(_ sender: UIButton) {
        print("button tapped");
        delegate?.takePicture();
    }
    
    func buttonEnabled() {
        delegate?.changeEnabledButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
}