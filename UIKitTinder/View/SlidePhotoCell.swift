import UIKit

class SlidePhotoCell: UICollectionViewCell {
    
    // MARK: - Private Properties

    private var photoImageView: UIImageView = .photoImageView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        photoImageView.fillWithSuperView()
    }
}
