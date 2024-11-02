import UIKit

class DetailPhotosCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let descriptionLabel: UILabel = .textBoldLabel(16)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        descriptionLabel.text = R.string.localizable.descriptionLabel()
        
        addSubview(descriptionLabel)
        descriptionLabel.fill(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
        )
    }
}
