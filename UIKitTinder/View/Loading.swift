import UIKit

class Loading: UIView {
    
    // MARK: - Private Properties
    
    private lazy var loadView: UIView = {
        let load = UIView()
        load.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        load.backgroundColor = R.color.loadViewBackgroundColor()
        load.layer.cornerRadius = 50
        load.layer.borderWidth = 1
        load.layer.borderColor = UIColor.red.cgColor
        
        return load
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.image = R.image.perfil()
        
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private  Methods
    
    private func setupSubviews() {
        addSubview(loadView)
        loadView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadView.center = center
        
        addSubview(profileImageView)
        profileImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        profileImageView.center = center
    }
    
    // MARK: - Public Methods
    
    func animate() {
        UIView.animate(
            withDuration: 1.3,
            animations: {
                self.loadView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
                self.loadView.center = self.center
                self.loadView.layer.cornerRadius = 125
                self.loadView.alpha = 0.3
            },
            completion: { _ in
                self.loadView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                self.loadView.center = self.center
                self.loadView.layer.cornerRadius = 50
                self.loadView.alpha = 0.3
                self.animate()
            }
        )
    }
}
