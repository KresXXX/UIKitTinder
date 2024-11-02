import UIKit

class CombineCardView: UIView {
    
    // MARK: - Public Properties

    var user: User? {
        didSet {
            guard let user = user else { return }
            photoImageView.image = user.image
            nameLabel.text = user.name
            ageLabel.text = String(user.age)
            descriptionLabel.text = user.description
        }
    }
    
    var onTapStackViewCallBack: ((User) -> Void)?
    
    let photoImageView: UIImageView = .photoImageView()
    let likeImageView: UIImageView = .iconImageView(image: R.image.cardLike())
    let dislikeImageView: UIImageView = .iconImageView(image: R.image.cardDeslike())
    
    let nameLabel: UILabel = .textBoldLabel(32, textColor: .white )
    let ageLabel: UILabel = .textLabel(28, textColor: .white )
    let descriptionLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    
    // MARK: - Initializers
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    private func setupSubviews() {
        let views: [UIView] = [
            photoImageView,
            dislikeImageView,
            likeImageView,
            nameLabel,
            ageLabel,
            descriptionLabel
        ]
        views.forEach { view in
            addSubview(view)
        }
        
        nameLabel.addShadow()
        ageLabel.addShadow()
        descriptionLabel.addShadow()
        
        let nameLabelStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        nameLabelStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nameLabelStackView, descriptionLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        let stackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapUserInfo))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(stackViewTapGesture)
    }
    
    private func setupConstraints() {
        dislikeImageView.fill(
            top: topAnchor,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 20)
        )
        
        likeImageView.fill(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        photoImageView.fillWithSuperView()
        
        if let stackView = subviews.compactMap({ $0 as? UIStackView }).first {
            stackView.fill(
                top: nil,
                leading: leadingAnchor,
                bottom: bottomAnchor,
                trailing: trailingAnchor,
                padding: .init(top: 0, left: 16, bottom: 16, right: 16)
            )
        }
    }

    // MARK: - Action
    
    @objc func onTapUserInfo() {
        if let user = self.user {
            self.onTapStackViewCallBack?(user)
        }
    }
}
