

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var delegateToHabits: UpdateHabitDelegate?


     lazy var name: UILabel = {
         var name = UILabel()
         name.translatesAutoresizingMaskIntoConstraints = false
         name.numberOfLines = 2
         name.lineBreakStrategy = .standard
         name.font = UIFont.systemFont(ofSize: 17, weight: .regular)
         return name
    }()
    
    lazy var date: UILabel = {
        var date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textColor = .systemGray2
        date.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        
       return date
   }()
    
    lazy var count: UILabel = {
        var count = UILabel()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        count.textColor = .systemGray
       return count
   }()
    
    lazy var checkButton: UIButton = {
        var checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.clipsToBounds = true
        checkButton.tintColor = .white
        checkButton.layer.cornerRadius = 19
        checkButton.layer.borderWidth = 1.5
        checkButton.addTarget(self, action: #selector(chekinHobit), for: .allTouchEvents)
        checkButton.layer.borderColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1).cgColor
      
       return checkButton
   }()
    
    
    var localTempHabit: Habit?
    //var localTempHabit = HabitsStore.shared.habits[0]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    func setupItem (_ habit: Habit) {
        localTempHabit = habit
        name.text = "\(habit.name)"
        name.textColor = habit.color
        date.text = "\(habit.dateString)"
        count.text = "Счётчик: \(localTempHabit?.trackDates.count ?? 0)"
        checkButton.layer.borderColor = habit.color.cgColor

        if  habit.isAlreadyTakenToday {
            checkButton.backgroundColor = UIColor(cgColor: checkButton.layer.borderColor!)
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            checkButton.backgroundColor = UIColor.white
        }
        


        
        
    }
    
    @objc func chekinHobit() {
        
        if  !localTempHabit!.isAlreadyTakenToday {
            checkButton.backgroundColor = UIColor(cgColor: checkButton.layer.borderColor!)
            
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)

            
            HabitsStore.shared.track(localTempHabit!)
            count.text = "Счётчик: \(localTempHabit?.trackDates.count ?? 0)"
            
            delegateToHabits?.update(text: "Сделана отметка о выполнении привычки. Коллекция обновлена.")
        }
        
    }
    
    
    

    
    private func setupContentView() {
        
        contentView.addSubview(name)
        contentView.addSubview(date)
        contentView.addSubview(count)
        contentView.addSubview(checkButton)
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
                                     checkButton.widthAnchor.constraint(equalToConstant: 38),
                                     checkButton.heightAnchor.constraint(equalToConstant: 38),
            
                                     name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                                     name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                     name.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -25),
                                     
                                     date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
                                     date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                     
                                     count.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                                     count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
                                    ])
        
        
    }
    
    
    
    
}
