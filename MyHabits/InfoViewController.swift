

import UIKit

class InfoViewController: UIViewController {
    
    // Здесь я специально сделал именно кастомный навбар, дабы в будущем обращаться в этот проект при необходимости как к шпаргалке
    private lazy var navigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.delegate = self
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.barTintColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        navigationBar.isTranslucent = false
        
        let item = UINavigationItem()
        item.title = "Информация"
        navigationBar.items = [item]
        
        return navigationBar
    }()
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var topicLabel = {
        let topicLabel = UILabel()
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.text = "Привычка за 21 день"
        topicLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return topicLabel
    }()

    
    private lazy var paragraph_1 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_2 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_3 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_4 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_5 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_6 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var paragraph_7 = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)

        setupNavigationBar()
        setupScrollView()
        
    }
    
    
    
    func setupNavigationBar(){
        
        view.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }

    
    
    
    func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [topicLabel,
         paragraph_1,
         paragraph_2,
         paragraph_3,
         paragraph_4,
         paragraph_5,
         paragraph_6,
         paragraph_7].forEach {contentView.addSubview($0)}
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
                                     
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                     
                                     topicLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
                                     topicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     
                                     paragraph_1.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 20),
                                     paragraph_1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     paragraph_1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     
                                     paragraph_2.topAnchor.constraint(equalTo: paragraph_1.bottomAnchor, constant: 17),
                                     paragraph_2.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_2.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),

                                     paragraph_3.topAnchor.constraint(equalTo: paragraph_2.bottomAnchor, constant: 17),
                                     paragraph_3.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_3.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),

                                     paragraph_4.topAnchor.constraint(equalTo: paragraph_3.bottomAnchor, constant: 17),
                                     paragraph_4.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_4.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),

                                     paragraph_5.topAnchor.constraint(equalTo: paragraph_4.bottomAnchor, constant: 17),
                                     paragraph_5.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_5.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),

                                     paragraph_6.topAnchor.constraint(equalTo: paragraph_5.bottomAnchor, constant: 17),
                                     paragraph_6.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_6.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),

                                     paragraph_7.topAnchor.constraint(equalTo: paragraph_6.bottomAnchor, constant: 17),
                                     paragraph_7.leadingAnchor.constraint(equalTo: paragraph_1.leadingAnchor),
                                     paragraph_7.trailingAnchor.constraint(equalTo: paragraph_1.trailingAnchor),
                                     paragraph_7.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            
                                     ])
                        
        
    }

    
}




extension InfoViewController: UINavigationBarDelegate{
    
    //данная реализация функции позволяет привязать кастомный навбар к верху и связать с системной инфой
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
