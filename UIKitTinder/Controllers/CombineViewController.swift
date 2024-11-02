import UIKit

enum Action {
    case like
    case superLike
    case dislike
}

class CombineViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var users: [User] = []
    
    // MARK: - Private Properties
    
    private lazy var profileButton: UIButton = .iconHeader(image: R.image.iconePerfil())
    private lazy var fireButton: UIButton = .iconHeader(image: R.image.iconeLogo())
    private lazy var messageButton: UIButton = .iconHeader(image: R.image.iconeChat())
    
    private lazy var dislikeButton: UIButton = .iconFooter(image: R.image.iconeDeslike())
    private lazy var likeButton: UIButton = .iconFooter(image: R.image.iconeLike())
    private lazy var superlikeButton: UIButton = .iconFooter(image: R.image.iconeSuperlike())
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        findUsers()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        profileButton.isHidden = true
        fireButton.isHidden = true
        messageButton.isHidden = true
        dislikeButton.isHidden = true
        likeButton.isHidden = true
        superlikeButton.isHidden = true
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        addHeader()
        addFooter()
    }
    
    private func findUsers() {
        UserService.instance.findUsers { users, _ in
            if let users = users {
                self.users = users
                self.addCards()
                self.addFooter()
                self.addHeader()
                
                self.profileButton.isHidden = false
                self.fireButton.isHidden = false
                self.messageButton.isHidden = false
                self.dislikeButton.isHidden = false
                self.likeButton.isHidden = false
                self.superlikeButton.isHidden = false
            }
        }
    }
    
    private func addHeader() {
        let stackViewHeader = createHeaderStackView()
        view.addSubview(stackViewHeader)
        
        view.addSubview(stackViewHeader)
        
        stackViewHeader.fill(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 70, left: 16, bottom: 0, right: 16)
        )
    }
    
    private func createHeaderStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [
                UIView(),
                profileButton,
                fireButton,
                messageButton,
                UIView()
            ])
        stackView.distribution = .equalSpacing
        
        profileButton.addTarget(self, action: #selector(profileButtonClick), for: .touchUpInside)
        fireButton.addTarget(self, action: #selector(fireButtonClick), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        
        return stackView
    }
    
    private func addFooter() {
        let stackView = createFooterStackView()
        view.addSubview(stackView)
        
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 12, bottom: 34, right: 12)
        )
    }
    
    private func createFooterStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [
                UIView(),
                dislikeButton,
                superlikeButton,
                likeButton,
                UIView()
            ])
        stackView.distribution = .equalSpacing
        
        dislikeButton.addTarget(self, action: #selector(onClickDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(onClickLike), for: .touchUpInside)
        superlikeButton.addTarget(self, action: #selector(onClickSuperlike), for: .touchUpInside)
        
        return stackView
    }
    
    private func addCards() {
        for user in self.users {
            let card = CombineCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            card.center = view.center
            card.user = user
            card.tag = user.id
            
            card.onTapStackViewCallBack = { _ in
                self.viewDetails(user)
            }
            
            setupCardGestures(card: card)
            view.insertSubview(card, at: 1)
        }
    }
    
    private func setupCardGestures(card: CombineCardView) {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        panGesture.cancelsTouchesInView = true
        card.addGestureRecognizer(panGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeft.direction = .left
        card.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRight.direction = .right
        card.addGestureRecognizer(swipeRight)
        
        view.insertSubview(card, at: 1)
    }
    
    private func viewDetails(_ user: User) {
        let detailsViewController = DetailsViewController()
        detailsViewController.user = user
        detailsViewController.modalPresentationStyle = .fullScreen
        
        detailsViewController.userActionCallback = { _, action in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if action == .like {
                    self.onClickLike()
                } else {
                    self.onClickDislike()
                }
            }
        }
        self.present(detailsViewController, animated: true, completion: nil)
    }
    
    private func verifyMatch(user: User) {
        if user.match {
            let matchViewController = MatchViewController()
            matchViewController.user = user
            matchViewController.modalPresentationStyle = .fullScreen
            
            self.present(matchViewController, animated: true, completion: nil)
        }
    }
    
    private func animateCard(rotationAngle: CGFloat, action: Action) {
        guard let user = users.first else { return }
        
        for view in view.subviews where view.tag == user.id {
            guard let card = view as? CombineCardView else { return }
            var center: CGPoint
            
            switch action {
            case .dislike:
                center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
            case .like:
                center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
            case .superLike:
                center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
            }
            
            UIView.animate(
                withDuration: 1,
                animations: {
                    card.center = center
                    card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                    card.dislikeImageView.alpha = action == .dislike ? 1 : 0
                    card.likeImageView.alpha = action == .like ? 1 : 0
                },
                completion: { _ in
                    if action == .like || action == .superLike {
                        self.verifyMatch(user: user)
                    }
                    self.removeCard(card: card)
                }
            )
        }
    }
    
    private func removeCard(card: UIView ) {
        card.removeFromSuperview()
        users = users.filter({ $0.id != card.tag })
    }
    
    // MARK: - Action
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view as? CombineCardView else { return }
        
        let translation = gesture.translation(in: view)
        let threshold: CGFloat = view.bounds.width / 2
        
        switch gesture.state {
        case .began, .changed:
            card.center = CGPoint(x: card.center.x + translation.x, y: card.center.y)
            gesture.setTranslation(.zero, in: view)
            
        case .ended:
            if abs(translation.x) > threshold {
                let action: Action = translation.x < 0 ? .dislike : .like
                let rotationAngle: CGFloat = action == .dislike ? 0.4 : 0.4
                
                animateCard(rotationAngle: rotationAngle, action: action)
                
                if action == .like {
                    if let user = self.users.first(where: { $0.id == card.tag }) {
                        self.verifyMatch(user: user)
                    }
                }
            } else {
                UIView.animate(withDuration: 2) {
                    card.center = self.view.center
                    card.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc func profileButtonClick() {
        print("profile button did tap")
    }
    
    @objc func fireButtonClick() {
        print("fire button did tap")
    }
    
    @objc func messageButtonClick() {
        print("message button did tap")
    }
    
    @objc func onClickLike() {
        animateCard(rotationAngle: 0.4, action: .like)
    }
    
    @objc func onClickSuperlike() {
        animateCard(rotationAngle: 0, action: .superLike)
    }
    
    @objc func onClickDislike() {
        animateCard(rotationAngle: 0.4, action: .dislike)
    }
    
    @objc private func swipeLeft() {
        animateCard(rotationAngle: 0.4, action: .dislike)
    }
    
    @objc private func swipeRight() {
        animateCard(rotationAngle: 0.4, action: .like)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension CombineViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
