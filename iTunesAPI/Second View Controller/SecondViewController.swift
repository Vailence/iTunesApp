
import UIKit
import SnapKit
import Kingfisher

class SecondViewController: UIViewController {

    var movieResults: [TopLevel] = []
    var artistName = String()
    var currentPage = 0

    lazy var button : UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.borderColor = .black
        button.backgroundColor = .white
        button.borderWidth = 1
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(findBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageController : UIPageControl = {
        let pageContr                           = UIPageControl()
        pageContr.numberOfPages                 = 10
        pageContr.currentPage                   = 0
        pageContr.tintColor                     = .red
        pageContr.pageIndicatorTintColor        = .black
        pageContr.currentPageIndicatorTintColor = .green
        return pageContr
    }()
    
    lazy var swipingCollectView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(hex: 0xE4F1FD)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.contentOffset.x = 0
        collectionView.register(SwipingCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieJSONRequest()
        setupButtons()
        setConstraints()
    }
}

// MARK - Setup Buttons and etc.
extension SecondViewController {    
    func setupButtons() {
        self.view.addSubviews([pageController, swipingCollectView, button])
        self.view.bringSubviewToFront(swipingCollectView)
        self.view.bringSubviewToFront(pageController)
        self.view.bringSubviewToFront(button)
    }
}

extension SecondViewController {
    func setConstraints () {
        swipingCollectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(25)
            make.width.equalTo(60)
        }
        
        pageController.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.size.equalTo(CGSize(width: 53, height: 8))
        }
        
        
    }
}

// MARK - Collection View Delegate
extension SecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResults.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frameWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + frameWidth / 4) / frameWidth)
        self.pageController.currentPage = self.currentPage
    }
}


// MARK - CollectionView Data Source
extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SwipingCollectionCell
        
        let string = movieResults[indexPath.row].artworkUrl100
        let replacingString = string.replacingOccurrences(of: "100x100", with: "500x500")
        let url = URL(string: replacingString)
        
        cell.swipeImg.kf.setImage(with: url)
        
        cell.artistName.text = movieResults[indexPath.row].artistName
        cell.collectionName.text = movieResults[indexPath.row].collectionName
        cell.trackName.text = movieResults[indexPath.row].trackName
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension SecondViewController {
    @objc func findBtn() {
        self.navigationController?.popViewController()
    }
}
