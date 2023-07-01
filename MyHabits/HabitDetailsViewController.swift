

import UIKit

class HabitDetailsViewController: UIViewController {
    

    var habit: Habit?
    
    
    weak var delegateToHabits: UpdateHabitDelegate?
    
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }

    
    func setupInputData (_ habitInput: Habit) {
        
        title = habitInput.name
        habit = habitInput
        
    }
    
    
    private func setupView () {
        
        view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        
        view.addSubview(tableView)

        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
        
    }
    

    
    @objc func editHabit() {
        let habitViewController = HabitViewController()
        habitViewController.delegateToUpdate = self
        habitViewController.setupNavigationForOldHabit()
        habitViewController.setupDataForOldHabit(habit!)
        
        
        let navHabitViewController = UINavigationController(rootViewController: habitViewController)
        navHabitViewController.modalPresentationStyle = .overFullScreen
        
        self.present(navHabitViewController, animated: true)
    }
    

    
}




extension HabitDetailsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        
        let today = dateFormatter.string(from: Date())
        let yesterday = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        let dateForRow = dateFormatter.string(from: HabitsStore.shared.dates.reversed()[indexPath.row])
        
        if dateForRow == today {
            config.text = "Сегодня"
        } else if dateForRow == yesterday {
            config.text = "Вчера"
        } else {
            config.text = dateForRow
        }
        
        if HabitsStore.shared.habit(habit!, isTrackedIn: HabitsStore.shared.dates.reversed()[indexPath.row]) {
            cell.accessoryType = .checkmark
        }
        
        cell.contentConfiguration = config
        return cell
    }

    
}




extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
    
}




extension HabitDetailsViewController: UpdateHabitDelegate {
    
    func update(text: String) {

        if text == "DELETE" {
            delegateToHabits?.update(text: "Привычка удалена. Коллекция обновлена.")
            navigationController?.popViewController(animated: true)
        } else {
            title = text
            delegateToHabits?.update(text: "Привычка отредактирована. Коллекция обновлена.")
        }
 
    }
    
}
