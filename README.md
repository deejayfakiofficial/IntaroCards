
    
    private enum Constants {
        static var heightCard: CGFloat = 250
    }
    
    private lazy var card: Card = {
        let card = Card()
        card.backgroundColor = .black
        return card
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCard()
    }
    
    private func configureCard() {
        view.addSubview(card)
        card.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.heightCard)
            make.centerX.centerY.equalToSuperview()
        }
        card.cornerRadius = Constants.heightCard / 4
        card.animation = .zoomOut
        card.setShadow(.large)
        card.tapBeginHandler = {
            self.view.backgroundColor = .systemGray
        }
        card.tapHandler = {
            self.view.backgroundColor = .systemFill
        }
    }
