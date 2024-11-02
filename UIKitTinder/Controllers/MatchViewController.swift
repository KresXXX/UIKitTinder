import UIKit

class MatchViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Public Properties

    var user: User? {
        didSet {
            if let user = user {
                photoImageView.image = user.image
                messageLabel.text = "\(user.name) \(R.string.localizable.messageLabel())"
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let photoImageView: UIImageView = .photoImageView()
    private let likeImageView: UIImageView = .photoImageView(image: R.image.iconeLike())
    private let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, alignment: .center)
    
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.sendMessageButton(), for: .normal)
        button.setTitleColor(R.color.titleColor(), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.backButton(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var messageField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 0.2
        textField.placeholder = R.string.localizable.messageField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
    }
    
    // MARK: - Public Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onClickSendMessage()
        return true
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        view.addSubview(photoImageView)
        photoImageView.fillWithSuperView()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        photoImageView.layer.addSublayer(gradient)
        
        messageField.delegate = self
        messageField.addSubview(sendMessageButton)
        
        messageLabel.adjustsFontSizeToFitWidth = true
        messageField.minimumFontSize = 0.2
        
        sendMessageButton.fill(
            top: messageField.topAnchor,
            leading: nil,
            bottom: messageField.bottomAnchor,
            trailing: messageField.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
        )
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        backButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
        sendMessageButton.addTarget(self, action: #selector(onClickSendMessage), for: .touchUpInside)
    }
    
    private func setupStackView() {
        let stackView = UIStackView(
            arrangedSubviews: [
                likeImageView,
                messageLabel,
                messageField,
                backButton
            ])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32)
        )
    }

    // MARK: - Action
    
    @objc func onClickSendMessage() {
        if let message = self.messageField.text {
            print(message)
        }
    }
    
    @objc func onClickBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
