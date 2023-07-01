

import UIKit




class HabitViewController: UIViewController {
    
    
    
    var habitForEdit: Habit?
    
    
    weak var delegateToUpdate: UpdateHabitDelegate?
    
    
    private lazy var labelForName = {
        let labelForName = UILabel()
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        labelForName.text = "НАЗВАНИЕ"
        labelForName.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelForName
    }()
    
    
    private lazy var labelForColor = {
        let labelForColor = UILabel()
        labelForColor.translatesAutoresizingMaskIntoConstraints = false
        labelForColor.text = "ЦВЕТ"
        labelForColor.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelForColor
    }()
    
    
    private lazy var labelForTime = {
        let labelForTime = UILabel()
        labelForTime.translatesAutoresizingMaskIntoConstraints = false
        labelForTime.text = "ВРЕМЯ"
        labelForTime.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelForTime
    }()
    
    
    private lazy var fieldForName = {
        let fieldForName = UITextField()
        fieldForName.translatesAutoresizingMaskIntoConstraints = false
        fieldForName.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        fieldForName.returnKeyType = UIReturnKeyType.done
        fieldForName.delegate = self
        return fieldForName
    } ()
    
    
    private lazy var circleForColor = {
        let circleForColor = UIButton()
        circleForColor.translatesAutoresizingMaskIntoConstraints = false
        circleForColor.backgroundColor = .green
        circleForColor.layer.cornerRadius = 15
        circleForColor.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return circleForColor
    }()
    
    
    private lazy var deleteHabitButton = {
        let deleteHabitButton = UIButton()
        deleteHabitButton.translatesAutoresizingMaskIntoConstraints = false
        deleteHabitButton.setTitle("Удалить привычку", for: .normal)
        deleteHabitButton.setTitleColor(.systemRed, for: .normal)
        deleteHabitButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        deleteHabitButton.addTarget(self, action: #selector(pushAlert), for: .touchDown)
        return deleteHabitButton
    }()
    
    
    private lazy var alertDelete = {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку «\(habitForEdit?.name ?? "")»?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {_ in
            self.deletingHabit()
            self.delegateToUpdate?.update(text: "DELETE")
            self.dismissNewHabit()
        } ))
        return alert
    }()
    
    
    private lazy var labelEveryDayIn = {
        let labelEveryDayIn = UILabel()
        labelEveryDayIn.translatesAutoresizingMaskIntoConstraints = false
        labelEveryDayIn.text = "Каждый день в "
        labelEveryDayIn.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return labelEveryDayIn
    }()
    
    
    private lazy var changedTime = {
        var changedTime = UILabel()
        changedTime.translatesAutoresizingMaskIntoConstraints = false
        changedTime.text = {
            var text = String()
            var timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short
            text = timeFormatter.string(from: Date())
            return text
        }()
        changedTime.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        changedTime.textColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        return changedTime
    }()

    
    private lazy var picker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(handler(sender:)), for: UIControl.Event.valueChanged)
        return picker
    }()
    
    
    let colorPicker = UIColorPickerViewController()




    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    
    func setupNavigationForNewHabit() {
        
        title = "Создать"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                                    title: "Сохранить",
                                    style: .done,
                                    target: self,
                                    action: #selector(saveNewHabits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                                    title: "Отменить",
                                    style: .plain,
                                    target: self,
                                    action: #selector(dismissNewHabit))
    }
    
    
    
    func setupNavigationForOldHabit() {
        
        title = "Править"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                                    title: "Сохранить",
                                    style: .done,
                                    target: self,
                                    action: #selector(saveOldHabits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                                    title: "Отменить",
                                    style: .plain,
                                    target: self,
                                    action: #selector(dismissNewHabit))
        
        view.addSubview(deleteHabitButton)
        
        NSLayoutConstraint.activate([deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
                                     deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
        
    }

    
    func setupDataForOldHabit(_ habit: Habit) {
        
        habitForEdit = habit
        fieldForName.text = habit.name
        picker.date = habit.date
        circleForColor.backgroundColor = habit.color
        
    }
    
    
    @objc func saveNewHabits() {

        if fieldForName.text != "" {
            HabitsStore.shared.habits.append(Habit(name: fieldForName.text!, date: picker.date, color: circleForColor.backgroundColor!))
            delegateToUpdate?.update(text: "Новая привычка добавлена. Теперь их \(HabitsStore.shared.habits.count). Коллекция обновлена.")
            dismissNewHabit()
        }

    }
    
    
    @objc func saveOldHabits() {

        if fieldForName.text != "" {
            for temp in HabitsStore.shared.habits {
                if temp == habitForEdit {
                    temp.name = fieldForName.text!
                    temp.date = picker.date
                    temp.color = circleForColor.backgroundColor!
                    HabitsStore.shared.save()
                }
            }
            delegateToUpdate?.update(text: "\(fieldForName.text!)")
            
            dismissNewHabit()
        }
    }
    
    
    @objc func changeColor() {
        presentColorPicker()
    }
    
    
    func presentColorPicker() {
        colorPicker.title = "Цвет для привычки"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .automatic
        self.present(colorPicker, animated: true)
    }
    
    
    @objc func pushAlert() {
        self.present(alertDelete, animated: true)
    }
    
    
    func deletingHabit() {

         for _  in HabitsStore.shared.habits{
             if let index = HabitsStore.shared.habits.firstIndex(of: habitForEdit!) {
                 HabitsStore.shared.habits.remove(at: index)
             }
         }
         
    }
    
    
    private func setupView() {
        
        view.backgroundColor = .white
                
        let app = UINavigationBarAppearance()
        app.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        navigationController?.navigationBar.scrollEdgeAppearance = app
        
        view.addSubview(labelForName)
        view.addSubview(fieldForName)
        view.addSubview(labelForColor)
        view.addSubview(circleForColor)
        view.addSubview(labelForTime)
        view.addSubview(labelEveryDayIn)
        view.addSubview(changedTime)
        view.addSubview(picker)
        
        NSLayoutConstraint.activate([labelForName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
                                     labelForName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                    
                                     fieldForName.topAnchor.constraint(equalTo: labelForName.bottomAnchor, constant: 7),
                                     fieldForName.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor),
                                     fieldForName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                    
                                     labelForColor.topAnchor.constraint(equalTo: fieldForName.bottomAnchor, constant: 15),
                                     labelForColor.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor),
                                    
                                     circleForColor.topAnchor.constraint(equalTo: labelForColor.bottomAnchor, constant: 7),
                                     circleForColor.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor),
                                     circleForColor.widthAnchor.constraint(equalToConstant: 30),
                                     circleForColor.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     labelForTime.topAnchor.constraint(equalTo: circleForColor.bottomAnchor, constant: 15),
                                     labelForTime.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor),
                                     
                                     labelEveryDayIn.topAnchor.constraint(equalTo: labelForTime.bottomAnchor, constant: 7),
                                     labelEveryDayIn.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor),
                                     
                                     changedTime.topAnchor.constraint(equalTo: labelEveryDayIn.topAnchor),
                                     changedTime.leadingAnchor.constraint(equalTo: labelEveryDayIn.trailingAnchor),
                                                                 
                                     picker.topAnchor.constraint(equalTo: labelEveryDayIn.bottomAnchor, constant: 15),
                                     picker.leadingAnchor.constraint(equalTo: labelForName.leadingAnchor)])
        
    }
    
    
    @objc func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short

        let strDate = timeFormatter.string(from: picker.date)
    
        changedTime.text = String(strDate)
    }

    
    @objc func dismissNewHabit() {
        dismiss(animated: true)
    }
    
    
}





extension HabitViewController: UITextFieldDelegate {

        func textFieldShouldReturn(_ fieldForName: UITextField)-> Bool {
                fieldForName.resignFirstResponder()

                return true
            }
    }





extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        circleForColor.backgroundColor = colorPicker.selectedColor
        
        }

}







