import UIKit

class DetailsViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var user: User? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var userActionCallback: ((User?, Action) -> Void)?
    
    // MARK: - Private Properties
    
    private let headerId = R.string.localizable.headerId()
    private let profileId = R.string.localizable.profileId()
    private let photosId = R.string.localizable.photosId()
    
    private lazy var likeButton: UIButton = .iconFooter(image: R.image.iconeLike())
    private lazy var dislikeButton: UIButton = .iconFooter(image: R.image.iconeDeslike())
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.iconeDown(), for: .normal)
        button.backgroundColor = R.color.backButtonBackgroundColor()
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addFooter()
        addBackButton()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        collectionView.backgroundColor = .white
        collectionView.register(DetailProfileCell.self, forCellWithReuseIdentifier: profileId)
        collectionView.register(DetailPhotosCell.self, forCellWithReuseIdentifier: photosId)
        collectionView.register(
            DetailHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId
        )
        self.addFooter()
        self.addBackButton()
    }
    
    private func configureView() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addBackButton() {
        view.addSubview(backButton)
        backButton.frame = CGRect(
            x: UIScreen.main.bounds.width - 69,
            y: UIScreen.main.bounds.height * 0.7 - 24,
            width: 48,
            height: 48
        )
        backButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
    }
    
    private func addFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView(), dislikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 43, right: 16)
        )
        
        likeButton.addTarget(self, action: #selector(onClickLike), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(onClickDeslike), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc func onClickBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickLike() {
        self.userActionCallback?(self.user, .like)
        self.onClickBack()
    }
    
    @objc func onClickDeslike() {
        self.userActionCallback?(self.user, .dislike)
        self.onClickBack()
    }
    
    // MARK: - Override Methods
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let originY = UIScreen.main.bounds.height * 0.7 - 24
        
        if scrollView.contentOffset.y > 0 {
            self.backButton.frame.origin.y = originY - scrollView.contentOffset.y
        } else {
            self.backButton.frame.origin.y = originY + scrollView.contentOffset.y * -1
        }
    }
}
    
// MARK: - UICollectionViewDelegateFlowLayout
    
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerId,
            for: indexPath
        ) as? DetailHeaderView else {
            return UICollectionReusableView()
        }
        header.user = self.user
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 2
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: profileId,
                for: indexPath
            ) as? DetailProfileCell else {
                return UICollectionViewCell()
            }
            cell.user = self.user
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: photosId,
            for: indexPath
        ) as? DetailPhotosCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.6
        
        if indexPath.item == 0 {
            let cell = DetailProfileCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.user = self.user
            cell.layoutIfNeeded()
            
            let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimatedSize.height
        }
        return .init(width: width, height: height)
    }
}
