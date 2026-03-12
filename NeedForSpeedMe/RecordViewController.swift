import UIKit
import Kingfisher
import SnapKit

class  RecordViewController: UIViewController {
    
    let loadedSettings = SaveLoadManager().loadSettings()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
       return backgroundImageView
    }()
    
    private let back: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "exitGreen"), for: .normal)
        back.setTitleColor(.brown, for: .normal)
        back.isEnabled = true
        return back
    }()
    
    private let recordLabel : UILabel = {
        let recordlabel = UILabel()
        recordlabel.textColor = .black
        recordlabel.numberOfLines = 0
        recordlabel.font = .systemFont(ofSize: 30)
        recordlabel.backgroundColor = .clear
        recordlabel.clipsToBounds = true
        recordlabel.text = "Records  🏆"
        return recordlabel
        
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm "
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    private var records: [RecordClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        loadRecords()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        view.addSubview(back)
        view.addSubview(recordLabel)
        
        title = "Records"
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(tableView)
        
        self.view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.image = UIImage(named: "desert2")
        backgroundImageView.frame = view.bounds
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(back.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        recordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(50)
        }
        
        back.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        
        let backAction = UIAction { _ in
            self.backAction ()
        }
        back.addAction(backAction, for: .touchUpInside)
        
    }
    
    private func backAction () {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func loadRecords() {
        
        records = SaveLoadManager().loadRecords()
        records.sort { $0.timeRace > $1.timeRace }
        let topThree = records.prefix(3)
        var text = ""
        for (index, record) in topThree.enumerated() {
            let dateString = dateFormatter.string(from: record.dateRace)
            text += "\(index + 1) место: \(record.namePlayer) — \(record.timeRace) сек — \(dateString)\n"
        }
        tableView.reloadData()
        
    }
}

extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        cell.configure(with: records[indexPath.row])
        cell.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        return cell
         
    }
}


