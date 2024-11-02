import UIKit

class DetailProfileCell: UICollectionViewCell {
    
    // MARK: - Public Properties

    var user: User? {
        didSet {
            if let user = user {
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                messageLabel.text = user.description
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = .textBoldLabel(32)
    private let ageLabel: UILabel = .textLabel(28)
    private let messageLabel: UILabel = .textLabel(18, numberOfLines: 2)
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        let nameAgeStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        nameAgeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nameAgeStackView, messageLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fillWithSuperView(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
}
