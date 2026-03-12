import UIKit
import SnapKit

final class TableViewCell : UITableViewCell {
    
    static var identifier : String {"\(Self.self)"}
    
    private let namelabel : UILabel = {
        let namelabel = UILabel()
        namelabel.textAlignment = .left
        namelabel.font = .systemFont(ofSize: 20, weight: .regular)
        namelabel.textColor = .black .withAlphaComponent(1)
        return namelabel
    }()
    
    private let timelabel : UILabel = {
        let timelabel = UILabel()
        timelabel.textAlignment = .center
        timelabel.font = .systemFont(ofSize: 20, weight: .regular)
        timelabel.textColor = .black .withAlphaComponent(1)
        return timelabel
    }()
    
    private let datelabel : UILabel = {
        let datelabel = UILabel()
        datelabel.textAlignment = .right
        datelabel.font = .systemFont(ofSize: 20, weight: .regular)
        datelabel.textColor = .black .withAlphaComponent(1)
        return datelabel
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm "
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(namelabel)
        namelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }
        contentView.addSubview(timelabel)
        timelabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(50)
        }
        
        contentView.addSubview(datelabel)
        datelabel.snp.makeConstraints { make in
            make.left.equalTo(timelabel.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview().inset(16)
        }
    }
    
    func configure(with record : RecordClass){
        namelabel.text = record.namePlayer
        timelabel.text = "\(record.timeRace)"
        datelabel.text = dateFormatter.string(from: record.dateRace)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        namelabel.text = nil
        timelabel.text = nil
        datelabel.text = nil
    }
}

