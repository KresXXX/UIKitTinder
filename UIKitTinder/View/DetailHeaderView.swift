import UIKit

class DetailHeaderView: UICollectionReusableView {
    
    // MARK: - Public Properties
    
    var user: User? {
        didSet {
            if let user = user {
                photoImageView.image = user.image
            }
        }
    }
    
    // MARK: - Private Properties

    private var photoImageView: UIImageView = .photoImageView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties

    private func setupSubviews() {
        addSubview(photoImageView)
        photoImageView.fillWithSuperView()
    }
}
