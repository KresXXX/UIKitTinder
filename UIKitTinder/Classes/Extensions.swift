import UIKit

extension UIButton {
    
    // MARK: - Public Methods

    static func iconFooter (image: UIImage?) -> UIButton {
        let button = UIButton()
        button.size(size: .init(width: 64, height: 64))
        button.setImage(image ?? UIImage(), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        
        return button
    }
    
    static func iconHeader (image: UIImage?) -> UIButton {
        let button = UIButton()
        button.size(size: .init(width: 32, height: 32))
        button.setImage(image ?? UIImage(), for: .normal)
        return button
    }
}

extension UIImageView {
    
    // MARK: - Public Methods

    static func photoImageView(image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView()
        
        if let image = image {
            imageView.image = image
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    static func iconImageView (image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image ?? UIImage()
        imageView.size(size: .init(width: 70, height: 70))
        imageView.alpha = 0.0
        return imageView
    }
}

extension UILabel {
    
    // MARK: - Public Methods

    static func textLabel(
        _ size: CGFloat,
        textColor: UIColor = .black,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = alignment
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        return label
    }
    
    static func textBoldLabel(
        _ size: CGFloat,
        textColor: UIColor = .black,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        return label
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1 )
        self.layer.masksToBounds = false
    }
}

extension UIView {
    
    // MARK: - Public Methods
    
    func fill(
        top: NSLayoutYAxisAnchor?,
        leading: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        trailing: NSLayoutXAxisAnchor?,
        padding: UIEdgeInsets = .zero,
        size: CGSize = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillWithSuperView(padding: UIEdgeInsets = .zero) {
        fill(top: superview?.topAnchor,
             leading: superview?.leadingAnchor,
             bottom: superview?.bottomAnchor,
             trailing: superview?.trailingAnchor,
             padding: padding
        )
    }
    
    func centerWithSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterX).isActive = true
        }
        
        if let superviewCenterY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func size(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
