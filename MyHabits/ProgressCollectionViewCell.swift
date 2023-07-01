import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    
    lazy var name = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        name.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        name.text = "Всё получится!"
        return name
   }()
    
    lazy var percent = {
        var percent = UILabel()
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        percent.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        return percent
   }()
    
    lazy var progressBar = {
        var progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        return progressBar
   }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupContentView() {
    
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(name)
        contentView.addSubview(percent)
        contentView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                                     
                                     percent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                                     
                                     progressBar.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
                                     progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                                     progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)])
        
        
    }
}
