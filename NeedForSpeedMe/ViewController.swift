import Kingfisher
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
       return backgroundImageView
    }()
    
    private let startButton : UIButton = {
        let startButton = UIButton()
        startButton.setTitle("GAME🚦", for: .normal)
        startButton.setTitleColor(UIColor.brown, for: .normal)
        startButton.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1)
        if let label = startButton.titleLabel {
            label.font = UIFont(name: "AvenirNext-Bold", size: 36)
        }
        startButton.layer.cornerRadius = 10
        startButton.isEnabled = true
        
        return startButton
    }()
    
    private let recordButton : UIButton = {
        let recordButton = UIButton()
        recordButton.setTitle("RECORD 🏆", for: .normal)
        recordButton.setTitleColor(.brown, for: .normal)
        recordButton.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1)
        if let label = recordButton.titleLabel {
            label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        }
        recordButton.layer.cornerRadius = 10
        recordButton.isEnabled = true
        return recordButton
    }()
    
    private let settingButton : UIButton = {
        let settingButton = UIButton()
        settingButton.setTitle("SETTINGS 🛠️", for: .normal)
        settingButton.setTitleColor(.brown, for: .normal)
        settingButton.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1)
        if let label = settingButton.titleLabel {
            label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        }
        settingButton.layer.cornerRadius = 10
        settingButton.isEnabled = true
        return settingButton
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    }
    override func viewDidAppear ( _ animated: Bool) {
        super.viewDidAppear(animated)
        
        startButton.dropShadow()
        recordButton.dropShadow()
        settingButton.dropShadow()
      
    }
    
    override func viewDidLayoutSubviews ( ) {
        super.viewDidLayoutSubviews()
        
        startButton.addGradient()
        recordButton.addGradient()
        settingButton.addGradient()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
       
        backgroundImageView.image = UIImage(named: "coverGame")
        
        view.addSubview(startButton)
        view.addSubview(recordButton)
        view.addSubview(settingButton)
        view.addSubview(label)
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(95)
            make.centerY.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()

        }
        
       recordButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(235)

        }
        
        settingButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerY.equalTo(startButton.snp.bottom).offset(65)
            make.centerX.equalToSuperview()

        }
        
        label.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()

        }
        
        let startButtonAction = UIAction { _ in
         self.startButtonAction()
        }
        let recordButtonAction = UIAction { _ in
         self.recordButtonAction()
        }
        let settingButtonAction = UIAction { _ in
         self.settingButtonAction()
        }
        
        startButton.addAction(startButtonAction, for: .touchUpInside)
        recordButton.addAction(recordButtonAction, for: .touchUpInside)
        settingButton.addAction(settingButtonAction, for: .touchUpInside)
        
        let firstWord = "Made "
        let secondWord = "on "
        let thirdWord = "Earth "
        let fourthWord = "by "
        let fifthWord = "humans"
        
        let attribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.purple,
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSMutableAttributedString(string: firstWord, attributes: attribute)
        
        let secondAttributedString = NSAttributedString(string: secondWord, attributes: attribute)
        let thirdAttributedString = NSAttributedString(string: thirdWord, attributes: attribute)
        let fourthAttributedString = NSAttributedString(string: fourthWord, attributes: attribute)
        let fifthAttributedString = NSAttributedString(string: fifthWord, attributes: attribute)
        
        attributedString.append(secondAttributedString)
        attributedString.append(thirdAttributedString)
        attributedString.append(fourthAttributedString)
        attributedString.append(fifthAttributedString)
        label.attributedText = attributedString
    }
    
    private func startButtonAction() {
        let gameController = GameViewController()
        navigationController?.pushViewController(gameController, animated: true)
    }
    
    private func recordButtonAction() {
        let recordController = RecordViewController()
        navigationController?.pushViewController(recordController, animated: true)
    }
    
    private func settingButtonAction() {
        let settingController = SettingViewController()
        navigationController?.pushViewController(settingController, animated: true)
    }
}

