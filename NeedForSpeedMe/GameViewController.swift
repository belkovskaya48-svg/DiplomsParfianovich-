
import CoreAudioKit
import UIKit
import Kingfisher
import SnapKit

class  GameViewController: UIViewController {
    
    var collisionTimer: Timer?
    var timer = Timer()
    var createBlockTimer = Timer()
    var blocks: [UIImageView] = []
    var counterTime = 0
    var player: AVAudioPlayer?
    var boomPlayer : AVAudioPlayer?
    
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    private let countMarkLabel : UILabel = {
        let countMarkLabel = UILabel()
        countMarkLabel.backgroundColor = .black
        countMarkLabel.alpha = 0.5
        countMarkLabel.layer.cornerRadius = 12
        countMarkLabel.textAlignment = .center
        countMarkLabel.textColor = .red
        countMarkLabel.font = .systemFont(ofSize: 50)
        countMarkLabel.clipsToBounds = true
        countMarkLabel.contentMode = .scaleAspectFill
        return countMarkLabel
    }()
    
    private let carView : UIImageView = {
        let carView = UIImageView()
        carView.backgroundColor = .clear
        carView.clipsToBounds = true
        carView.contentMode = .scaleAspectFill
        return carView
    }()
    
    private let boomView : UIImageView = {
        let boomView = UIImageView()
        boomView.image = UIImage(named: "boomPicture")
        boomView.contentMode = .scaleAspectFit
        boomView.clipsToBounds = true
        boomView.isHidden = true
        return boomView
    }()
    
    private let roadView : UIImageView = {
        let roadView = UIImageView()
        roadView.backgroundColor = .lightGray
        roadView.clipsToBounds = true
        return roadView
    }()
    
    private let roadExtraView : UIImageView = {
        let roadExtraView = UIImageView()
        roadExtraView.backgroundColor = .lightGray
        roadExtraView.clipsToBounds = true
        return roadExtraView
    }()
    
    private let goButton: UIButton = {
        let goButton = UIButton()
        goButton.setImage(UIImage(named: "start"), for: .normal)
        goButton.imageView?.contentMode = .scaleAspectFit
        goButton.imageView?.clipsToBounds = true
        goButton.isEnabled = true
        return goButton
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "exitButton"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.imageView?.clipsToBounds = true
        backButton.isEnabled = true
        return backButton
    }()
    
    private let leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "leftButton"), for: .normal)
        leftButton.imageView?.contentMode = .scaleAspectFill
        leftButton.imageView?.clipsToBounds = true
        leftButton.isEnabled = true
        return leftButton
    }()
    
    private let rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "rightButton"), for: .normal)
        rightButton.imageView?.contentMode = .scaleAspectFill
        rightButton.imageView?.clipsToBounds = true
        rightButton.isEnabled = true
        return rightButton
    }()
    
    private let audioStopButton: UIButton = {
        let audioStopButton = UIButton()
        audioStopButton.setTitle("🔔", for: .normal)
        audioStopButton.isEnabled = true
        return audioStopButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        carView.dropShadow()
    
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        
        view.addSubview(roadExtraView)
        view.addSubview(roadView)
        view.addSubview(carView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(backButton)
        view.addSubview(goButton)
        view.addSubview(audioStopButton)
        view.addSubview(countMarkLabel)
        view.bringSubviewToFront(backButton)
        
        view.bringSubviewToFront(rightButton)
        view.bringSubviewToFront(leftButton)
        
        
        roadView.image = UIImage(named: "road")
        roadExtraView.image = UIImage(named: "road")
        
        carView.image = UIImage(named: "\(SaveLoadManager().loadSettings().carName)")
        countMarkLabel.text = "0"
        
        let backAction = UIAction { _ in
            self.backAction ()
        }
        backButton.addAction(backAction, for: .touchUpInside)
        
        let leftAction = UIAction { _ in
            self.leftAction ()
        }
        leftButton.addAction(leftAction, for: .touchUpInside)
        
        let rightAction = UIAction { _ in
            self.rightAction ()
        }
        rightButton.addAction(rightAction, for: .touchUpInside)
        
        let goAction = UIAction { _ in
            self.goAction()
            
        }
        goButton.addAction(goAction, for: .touchUpInside)
        
        let audioStopAction = UIAction { _ in
            self.audioStopAction()
            
        }
        audioStopButton.addAction(audioStopAction, for: .touchUpInside)
        
        carView.frame = CGRect(x: 215, y: 600, width: 55, height: 110)
        
        roadView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        roadExtraView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.top)
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        goButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(130)
        }
        countMarkLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        leftButton.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(110)
            make.bottom.equalToSuperview().inset(50)
            make.left.equalTo(roadView.snp.left).offset(100)
        }
        rightButton.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(110)
            make.bottom.equalToSuperview().inset(50)
            make.right.equalTo(roadView.snp.right).inset(100)
        }

        audioStopButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
    }
    
    
    private func backAction () {
        saveRecords()
        audioStopAction()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func leftAction () {
        var newX = carView.frame.origin.x - 80
        if newX < 0 {
            newX = 0
        }
        let maxX = view.bounds.width - carView.frame.width
        if newX > maxX {
            newX = maxX
        }
        carView.frame.origin.x = newX
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func  rightAction () {
        var newX = carView.frame.origin.x + 80
        if newX < 0 {
            newX = 0
        }
        let maxX = view.bounds.width - carView.frame.width
        if newX > maxX {
            newX = maxX
        }
        
        carView.frame.origin.x = newX
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func roadAnimate(){
        self.roadView.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.roadExtraView.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.curveLinear, .repeat]){
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.roadView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalToSuperview()
            }
            self.roadExtraView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.view.snp.top)
                make.height.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
    }
    
    func createFallingBlock() {
        
        let blockWidth: CGFloat = 55
        let blockHeight: CGFloat = 80
        let leftLaneX: CGFloat = 130
        let rightLaneX: CGFloat = 210
        
        let randomX = Bool.random() ? leftLaneX : rightLaneX
        
        let newBlock = UIImageView(frame: CGRect(x: randomX, y: -blockHeight, width: blockWidth, height: blockHeight))
        newBlock.image = UIImage(named: "\(SaveLoadManager().loadSettings().blockName)")
        
        newBlock.clipsToBounds = true
        newBlock.translatesAutoresizingMaskIntoConstraints = true
        newBlock.contentMode = .scaleAspectFill
        
        
        view.insertSubview(newBlock, belowSubview: leftButton)
        view.insertSubview(newBlock, belowSubview: rightButton)
        blocks.append(newBlock)
        
        UIView.animate(withDuration: 6.0, delay: 0, options: .curveLinear, animations: {
            newBlock.frame.origin.y = self.view.frame.height + 100
        }) { finished in
            if finished {
                newBlock.removeFromSuperview()
                if let index = self.blocks.firstIndex(of: newBlock) {
                    self.blocks.remove(at: index)
                }
            }
        }
    }
    
    func checkCollisions() {
        
        let carFrame = carView.layer.presentation()?.frame ?? carView.frame
        
        let carX = carView.layer.presentation()?.frame

        if let midXValue = carX?.midX {
            if midXValue >= 295 || midXValue <= 135 {
                collisionTimer?.invalidate()
                timer.invalidate()
                collisionTimer = nil
                handleGameOver()
            }
        }
        
        for block in blocks {
            if let blockFrame = block.layer.presentation()?.frame {
                if carFrame.intersects(blockFrame) {
                    collisionTimer?.invalidate()
                    timer.invalidate()
                    collisionTimer = nil
                    handleGameOver()
                }
            }
        }
    }
    
    func handleGameOver() {
        
        createBlockTimer.invalidate()
        saveRecords()
       
        if let carPos = carView.layer.presentation()?.frame {
            view.addSubview(boomView)
           
            boomView.frame = CGRect(x: carPos.midX - 45, y: carPos.midY - 110, width: 120, height: 120)
        }
        
        boomView.isHidden = false
       view.bringSubviewToFront(boomView)
        
        view.subviews.forEach { subview in
            if subview is UIImageView && subview != boomView {
                if let presentationFrame = subview.layer.presentation()?.frame {
                    subview.layer.removeAllAnimations()
                    subview.frame = presentationFrame
                }
            }
        }
        audioStopAction()
        playBoomAudio()
        
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   self.showAlert(
                       title: "Упс! Конец заезда!🚨",
                       message: "Попробуй снова, у тебя получится! 🛣️",
                       exitTap: { self.backAction() },
                       restart: { self.restartGame() }
                   )
               }
    }
    
    func restartGame() {
        
        blocks.forEach { $0.removeFromSuperview() }
        blocks.removeAll()
        boomView.removeFromSuperview()
      
        counterTime = 0
        countMarkLabel.text = "0"
        carView.frame = CGRect(x: 215, y: 550, width: 55, height: 110)
        
        goAction()
    }
    
    func timerStart() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.counterTime += 1
            
            self.countMarkLabel.text = "\(self.counterTime)"
        }
        )}
    
    func goAction() {
        timerStart()
        playAudio()
        roadAnimate()
        createBlockTimer = Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true) { [weak self] _ in
            self?.createFallingBlock()
        }
        
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            self?.checkCollisions()
        }
        goButton.removeFromSuperview()
    }
    
    func saveRecords () {
        
        let time = Int(counterTime)
        
        let currentSettings = SaveLoadManager().loadSettings()
        let namePlayer = currentSettings.userName
        
        let now = Date()
        
        let newRecord = RecordClass(timeRace: time, dateRace: now, namePlayer: namePlayer)
        
        var records = SaveLoadManager().loadRecords()
        records.append(newRecord)
        SaveLoadManager().saveRecords(records)
    }
    
    private func playAudio() {
        guard let url = Bundle.main.url(forResource: "Hush-Fired up", withExtension: "mp3") else {return}
        
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    private func playBoomAudio() {
        guard let url = Bundle.main.url(forResource: "BoomSound", withExtension: "mp3") else {return}
        
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        boomPlayer = try? AVAudioPlayer(contentsOf: url)
        boomPlayer?.play()
        
    }
    
    func showAlert(title: String, message: String, exitTap: @escaping () -> Void, restart: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Перезапустить", style: .default) { _ in
            restart()
        }
        
        let exitAction = UIAlertAction(title: "Выход", style: .cancel) { _ in
            exitTap()
        }
        
        alert.addAction(restartAction)
        alert.addAction(exitAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioStopAction() {
        player?.stop()
    }
    
    
    
    
}


