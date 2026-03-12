import UIKit
import Kingfisher
import SnapKit

class  SettingViewController: UIViewController {
    
    var saveLoadManager = SaveLoadManager()
    let carArray = ["orangeCar","pinkCar","yellowCar"]
    let blockArray = ["cactus","stones","scorpion"]
    var carCurrentIndex = 0
    var blockCurrentIndex = 0
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
       return backgroundImageView
    }()
    
    private let carViewContainer : UIView = {
        let carViewContainer = UIView()
        carViewContainer.backgroundColor = .clear
        return carViewContainer
    }()
    
    private let blockViewContainer : UIView = {
        let blockViewContainer = UIView()
        blockViewContainer.backgroundColor = .clear
        return blockViewContainer
    }()
    
    private let avatarImageView : UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = .blue
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    
    private let selectCarImageView : UIImageView = {
        let selectCarImageView = UIImageView()
        selectCarImageView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        selectCarImageView.layer.cornerRadius = 20
        selectCarImageView.contentMode = .scaleAspectFit
        selectCarImageView.layer.masksToBounds = true
        selectCarImageView.isUserInteractionEnabled = true
        return selectCarImageView
    }()
    
    private let selectBlockImageView : UIImageView = {
        let selectBlockImageView = UIImageView()
        selectBlockImageView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        selectBlockImageView.layer.cornerRadius = 20
        selectBlockImageView.contentMode = .scaleAspectFit
        selectBlockImageView.layer.masksToBounds = true
        selectBlockImageView.isUserInteractionEnabled = true
        return selectBlockImageView
    }()
    
    private let rightCarButton: UIButton = {
        let rightCarButton = UIButton()
        rightCarButton.setImage(UIImage(named: "rightGreenButton"), for: .normal)
        rightCarButton.isEnabled = true
        return rightCarButton
    }()
    
    private let leftCarButton: UIButton = {
        let leftCarButton = UIButton()
        leftCarButton.setImage(UIImage(named: "leftGreenButton"), for: .normal)
        leftCarButton.isEnabled = true
        return leftCarButton
    }()
    
    private let rightBlockButton: UIButton = {
        let rightBlockButton = UIButton()
        rightBlockButton.setImage(UIImage(named: "rightGreenButton"), for: .normal)
        rightBlockButton.setTitleColor(.brown, for: .normal)
        rightBlockButton.isEnabled = true
        return rightBlockButton
    }()
    
    private let leftBlockButton: UIButton = {
        let leftBlockButton = UIButton()
        leftBlockButton.setImage(UIImage(named: "leftGreenButton"), for: .normal)
        leftBlockButton.setTitleColor(.brown, for: .normal)
        leftBlockButton.isEnabled = true
        return leftBlockButton
    }()
    
    private let back: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "exitGreen"), for: .normal)
        back.isEnabled = true
        return back
    }()
    
    private let settingLabel: UILabel = {
        let settingLabel = UILabel()
        settingLabel.textColor = .black
        settingLabel.font = .systemFont(ofSize: 30)
        settingLabel.text = "SETTINGS"
        return settingLabel
    }()
    
    private let textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Player name"
        textField.borderStyle = .roundedRect
        let text1 = textField.text
        return textField
    }()
    
    //MARK: объект настроек загружается
    private var settings = SaveLoadManager().loadSettings()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettings()
        configureUI()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageView.roundCorners(radius: 90)
        
    }
    
    func configureUI() {
        
        textField.text = settings.userName
        selectCarImageView.image = settings.carImage
        selectBlockImageView.image = settings.blockImage
        
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(back)
        view.addSubview(settingLabel)
        view.addSubview(avatarImageView)
        view.addSubview(textField)
        view.addSubview(rightCarButton)
        view.addSubview(leftCarButton)
        view.addSubview(rightBlockButton)
        view.addSubview(leftBlockButton)
        view.addSubview(carViewContainer)
        view.addSubview(blockViewContainer)
        
        carViewContainer.addSubview(selectCarImageView)
        blockViewContainer.addSubview(selectBlockImageView)
        
        self.view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.image = UIImage(named: "desert")
        backgroundImageView.frame = view.bounds
        
        back.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110)
            make.height.equalTo(180)
            make.width.equalTo(180)
        }
        
        carViewContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).offset(100)
            make.width.equalTo(180)
            make.height.equalTo(180)
        }
        blockViewContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(carViewContainer.snp.bottom).offset(50)
            make.width.equalTo(180)
            make.height.equalTo(180)
        }
        selectCarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(10)
            make.top.equalTo(avatarImageView.snp.bottom).offset(100)
            make.height.equalTo(180)
            make.width.equalTo(180)
        }
        
        selectBlockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(10)
            make.top.equalTo(textField.snp.bottom).offset(250)
            make.height.equalTo(180)
            make.width.equalTo(180)
        }
        
        rightCarButton.snp.makeConstraints { make in
            make.left.equalTo(carViewContainer.snp.right).offset(10)
            make.centerY.equalTo(carViewContainer)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        leftCarButton.snp.makeConstraints { make in
            make.right.equalTo(carViewContainer.snp.left).offset(-10)
            make.centerY.equalTo(carViewContainer)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        rightBlockButton.snp.makeConstraints { make in
            make.left.equalTo(blockViewContainer.snp.right).offset(10)
            make.centerY.equalTo(blockViewContainer)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        leftBlockButton.snp.makeConstraints { make in
            make.right.equalTo(blockViewContainer.snp.left).offset(-10)
            make.centerY.equalTo(blockViewContainer)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        settingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(60)
        }
        let backAction = UIAction { _ in
            self.backAction ()
        }
        back.addAction(backAction, for: .touchUpInside)
        
        let rightCarAction = UIAction { _ in
            self.rightCarAction ()
        }
        rightCarButton.addAction(rightCarAction, for: .touchUpInside)
        
        let leftCarAction = UIAction { _ in
            self.leftCarAction ()
        }
        leftCarButton.addAction(leftCarAction, for: .touchUpInside)
        
        let rightBlockAction = UIAction { _ in
            self.rightBlockAction ()
        }
        rightBlockButton.addAction(rightBlockAction, for: .touchUpInside)
        
        let leftBlockAction = UIAction { _ in
            self.leftBlockAction ()
        }
        leftBlockButton.addAction(leftBlockAction, for: .touchUpInside)
        
        let emptyRecognizer = UITapGestureRecognizer(target: self, action: #selector(sideKeyboard))
        view.addGestureRecognizer(emptyRecognizer)
        
        
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickerAction))
        avatarImageView.addGestureRecognizer(imageRecognizer)
        
        
    }
    func loadSettings() {
        
        if let savedSettings = UserDefaults.standard.get(decodableType: SettingsClass.self, forKey: Keys.settingsUser.rawValue) {
            settings = savedSettings
            textField.text = settings.userName
            selectCarImageView.image = settings.carImage
            selectBlockImageView.image = settings.blockImage
            
            //MARK: нужно для кнопок (чтобы порядок в массиве не нарушался)
            if let carIndex = carArray.firstIndex(of: settings.carName) {
                carCurrentIndex = carIndex
            }
            if let blockIndex = blockArray.firstIndex(of: settings.blockName) {
                blockCurrentIndex = blockIndex
            }
        }
        
        if let imageName = saveLoadManager.loadImageName(),
           let image = saveLoadManager.loadImage(name: imageName) {
            avatarImageView.image = image
        }
        }

        private func backAction () {
            
            settings.userName = textField.text ?? ""
            settings.carName = carArray[carCurrentIndex]
            settings.blockName = blockArray[blockCurrentIndex]
            saveLoadManager.saveSettings(settings)
            
            navigationController?.popToRootViewController(animated: true)
            
        }
    
        func rightCarAction () {
            var carNextIndex = carCurrentIndex + 1
           
            if carNextIndex >= carArray.count {
                carNextIndex = 0
            }
            let extraCarImageView = UIImageView()
            extraCarImageView.backgroundColor = .clear
            extraCarImageView.layer.cornerRadius = 10
            extraCarImageView.contentMode = .scaleAspectFit
            extraCarImageView.clipsToBounds = true
             
            view.addSubview(extraCarImageView)
            
            extraCarImageView.snp.makeConstraints { make in
                make.left.equalTo(view.snp.right)
                make.centerY.equalTo(carViewContainer)
                make.height.width.equalTo(carViewContainer)
            }
            self.view.layoutIfNeeded()
             
            extraCarImageView.image = UIImage(named: "\(carArray[carNextIndex])")
             
            UIView.animate(withDuration: 0.3) {
                extraCarImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview().inset(10)
                    make.top.equalTo(self.avatarImageView.snp.bottom).offset(100)
                    make.height.equalTo(180)
                    make.width.equalTo(180)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
                let currentCarImageName = self.carArray[carNextIndex]
                if let verifiedImage = UIImage(named: currentCarImageName) {
                    self.selectCarImageView.image = verifiedImage
                }
                
                self.carCurrentIndex = carNextIndex
                extraCarImageView.removeFromSuperview()
            }
            
            }
        
        func leftCarAction () {
            
            var carBackIndex = carCurrentIndex - 1
           
            if carBackIndex < 0  {
                carBackIndex = carArray.count - 1
            }
            
            let extraCarImageView = UIImageView()
            extraCarImageView.backgroundColor = .clear
            extraCarImageView.layer.cornerRadius = 10
            extraCarImageView.contentMode = .scaleAspectFit
            extraCarImageView.clipsToBounds = true
             
            view.addSubview(extraCarImageView)
            
            extraCarImageView.snp.makeConstraints { make in
                make.right.equalTo(view.snp.left)
                make.centerY.equalTo(carViewContainer)
                make.height.width.equalTo(carViewContainer)
            }
            self.view.layoutIfNeeded()
             
            extraCarImageView.image = UIImage(named: "\(carArray[carBackIndex])")
             
            UIView.animate(withDuration: 0.3) {
                extraCarImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview().inset(10)
                    make.top.equalTo(self.avatarImageView.snp.bottom).offset(100)
                    make.height.equalTo(180)
                    make.width.equalTo(180)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
                let currentCarImageName = self.carArray[carBackIndex]
                if let verifiedImage = UIImage(named: currentCarImageName) {
                    self.selectCarImageView.image = verifiedImage
                }
                
                self.carCurrentIndex = carBackIndex
                extraCarImageView.removeFromSuperview()
            }
        
            
        }
        
        func rightBlockAction () {
            
            var blockNextIndex = blockCurrentIndex + 1
           
            if blockNextIndex >= blockArray.count {
                blockNextIndex = 0
            }
            let extraBlockImageView = UIImageView()
            extraBlockImageView.backgroundColor = .clear
            extraBlockImageView.layer.cornerRadius = 10
            extraBlockImageView.contentMode = .scaleAspectFit
            extraBlockImageView.clipsToBounds = true
             
            view.addSubview(extraBlockImageView)
            
            extraBlockImageView.snp.makeConstraints { make in
                make.left.equalTo(view.snp.right)
                make.centerY.equalTo(blockViewContainer)
                make.height.width.equalTo(blockViewContainer)
            }
            self.view.layoutIfNeeded()
             
            extraBlockImageView.image = UIImage(named: "\(blockArray[blockNextIndex])")
             
            UIView.animate(withDuration: 0.3) {
                extraBlockImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview().inset(10)
                    make.top.equalTo(self.textField.snp.bottom).offset(250)
                    make.height.equalTo(180)
                    make.width.equalTo(180)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
                let currentBlockImageName = self.blockArray[blockNextIndex]
                if let verifiedImage = UIImage(named: currentBlockImageName) {
                    self.selectBlockImageView.image = verifiedImage
                }
                
                self.blockCurrentIndex = blockNextIndex
                extraBlockImageView.removeFromSuperview()
            }
           
        }
        
        func leftBlockAction () {
            
            var blockBackIndex = blockCurrentIndex - 1
           
            if blockBackIndex < 0  {
                blockBackIndex = blockArray.count - 1
            }
            
            let extraBlockImageView = UIImageView()
            extraBlockImageView.backgroundColor = .clear
            extraBlockImageView.layer.cornerRadius = 10
            extraBlockImageView.contentMode = .scaleAspectFit
            extraBlockImageView.clipsToBounds = true
             
            view.addSubview(extraBlockImageView)
            
            extraBlockImageView.snp.makeConstraints { make in
                make.right.equalTo(view.snp.left)
                make.centerY.equalTo(blockViewContainer)
                make.height.width.equalTo(blockViewContainer)
            }
            self.view.layoutIfNeeded()
             
            extraBlockImageView.image = UIImage(named: "\(blockArray[blockBackIndex])")
             
            UIView.animate(withDuration: 0.3) {
                extraBlockImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview().inset(10)
                    make.top.equalTo(self.textField.snp.bottom).offset(250)
                    make.height.equalTo(180)
                    make.width.equalTo(180)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
                let currentBlockImageName = self.blockArray[blockBackIndex]
                if let verifiedImage = UIImage(named: currentBlockImageName) {
                    self.selectBlockImageView.image = verifiedImage
                }
                
                self.blockCurrentIndex = blockBackIndex
                extraBlockImageView.removeFromSuperview()
            }
        
            
        }
    
        @objc func sideKeyboard(_ sender: UITapGestureRecognizer) {
          
            view.endEditing(true)
        }
        
        private func showPicker(_ sourceType : UIImagePickerController.SourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true)
        }
    
        private func showImagePickerAlert() {
            let alert = UIAlertController(title: "Choose media source", message: "Do you want to leave the screen?", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) {[weak self] _ in self?.showPicker(.camera)}
            alert.addAction(cameraAction)
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) {[weak self] _ in self?.showPicker(.photoLibrary)}
            alert.addAction(libraryAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
        
        @objc func pickerAction (_ sender: UITapGestureRecognizer) {
            
            showImagePickerAlert()
        }
        
    }

    extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
            self.avatarImageView.image = image
            
            if let imageName = saveLoadManager.saveImage(image: image) {
                saveLoadManager.saveImageName(imageName)
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true)
        }
    }

    extension SettingViewController: UITextFieldDelegate {
        func textFieldShouldReturn (_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }
    }
    
    
    

