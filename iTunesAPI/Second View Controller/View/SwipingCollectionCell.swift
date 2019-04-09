
import UIKit
import Cartography
import SwifterSwift
import SnapKit

class SwipingCollectionCell: UICollectionViewCell {
    
    lazy var swipeImg: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 0 , height: 0))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var artistName: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(hex: 0x297FCA)
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont(name: "AvenirNext-Medium", size: 24)
        title.textAlignment = .center
        return title
    }()
    
    lazy var collectionName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: 0x297FCA)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: 0x297FCA)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var swipeView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Some error")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setUp()
        swipeImg.layer.zPosition = -1
        swipeView.layer.zPosition = 0
        artistName.layer.zPosition = 1
        collectionName.layer.zPosition = 1
    }
}

extension SwipingCollectionCell {
    
    private func setUp() {
        self.addSubviews([swipeImg, artistName, collectionName, swipeView, trackName])
        
        swipeView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        
        artistName.snp.makeConstraints { (make) in
            make.top.equalTo(swipeView).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(27)
        }
        
        collectionName.snp.makeConstraints { (make) in
            make.top.equalTo(artistName.snp.bottom).offset(10)
            make.left.right.height.equalTo(artistName)
        }
        
        trackName.snp.makeConstraints { (make) in
            make.top.equalTo(collectionName.snp.bottom).offset(10)
            make.left.right.height.equalTo(artistName)
        }
        
        swipeImg.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(swipeView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(swipeImg.snp.height)
        }
    }
}
