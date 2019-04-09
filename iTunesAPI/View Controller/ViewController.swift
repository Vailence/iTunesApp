
import UIKit
import SnapKit
import SwifterSwift

class ViewController: UIViewController {

    lazy var textField : UITextField = {
        let tField = UITextField()
        tField.placeholder = "Artist name"
        tField.borderWidth = 1.0
        tField.addPaddingLeft(16)
        tField.borderColor = .black
        return tField
    }()
    
    lazy var button : UIButton = {
        let button = UIButton()
        button.setTitle("Find", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.borderColor = .blue
        button.borderWidth = 3
        button.addTarget(self, action: #selector(findBtn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupViews() {
        view.addSubviews([textField, button])
        view.backgroundColor = .white
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(30)
            make.left.right.height.equalTo(textField)
        }
    }
    
    
    @objc func findBtn() {
        let vc = SecondViewController()
        if textField.isEmpty == false {
            let aString = textField.text
            let newString = aString!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            vc.artistName = newString
            self.navigationController?.pushViewController(vc)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Заполните данные в текстовом поле", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            }
}
