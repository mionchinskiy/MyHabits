

import UIKit


///Протокол, позволяющий передавать данные от VC к VC в "обратном порядке".
///text - используется для 1) фильтрации получаемых делегатом сигналов; 2) передачи отредактированного Habit.name из HabitViewController в HabitDetailsViewController.title
protocol UpdateHabitDelegate: AnyObject {
    
    func update(text: String)
    
}





class HabitsViewController: UIViewController {

    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        
        //создает одну дефолтную привычку при пустом HabitsStore.shared.habits
//        if HabitsStore.shared.habits.isEmpty {
//            HabitsStore.shared.habits.append(Habit(name: "Добавьте свою первую привычку!", date: Date(), color: .systemGreen))
//        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //возвращает требуемый вид navigationBar после закрытия(pop) экземпляра HabitDetailsViewController
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

 
    
    func setupNavigationBar(){
        
        self.title = "Сегодня"
        navigationController?.navigationBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                                    barButtonSystemItem: .add,
                                    target: self,
                                    action: #selector(newHabit))

        let app = UINavigationBarAppearance()
        app.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        navigationController?.navigationBar.scrollEdgeAppearance = app

    }
    
    
    func setupTableView() {

        view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
    }

    
    @objc func newHabit() {

        let habitViewController = HabitViewController()
        habitViewController.setupNavigationForNewHabit()
        habitViewController.delegateToUpdate = self
        
        let navHabitViewController = UINavigationController(rootViewController: habitViewController)
        navHabitViewController.modalPresentationStyle = .overFullScreen

        self.present(navHabitViewController, animated: true)

    }

    
}






extension HabitsViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as! HabitCollectionViewCell
        habitCell.delegateToHabits = self

        let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as! ProgressCollectionViewCell
        
        if indexPath.row == 0 {
            
            progressCell.progressBar.progress = HabitsStore.shared.todayProgress
            progressCell.percent.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
            return progressCell
            
        } else {
            
            habitCell.setupItem(HabitsStore.shared.habits[indexPath.item-1])

            return habitCell
        
        }

    }
    

}





extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = self.view.window?.windowScene?.screen.bounds.size
        
        if indexPath.item != 0 {
            return CGSize(width: screenSize!.width-32, height: 130)
        } else {
            return CGSize(width: screenSize!.width-32, height: 60)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom:22, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.setupInputData(HabitsStore.shared.habits[indexPath.item-1])
            habitDetailsViewController.delegateToHabits = self
            
            self.navigationController?.pushViewController(habitDetailsViewController, animated: true)
            
        }
    }
    
    
}


extension HabitsViewController: UpdateHabitDelegate {
    
    func update(text: String) {
        
        collectionView.reloadData()
        print(text)
        
    }
    
}
