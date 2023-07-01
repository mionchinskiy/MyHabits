

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // создаем 2 контентных вьюконтроллера
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        
        // создаем 2 контейнерных вьюконтроллера
        let navigationHabitsViewController = UINavigationController(rootViewController: habitsViewController)
        let navigationInfoViewController = UINavigationController(rootViewController: infoViewController)
        
        //отключаем дефолтные бары, тк в самих классах зададим кастомные
        navigationHabitsViewController.navigationBar.isHidden = false
        navigationInfoViewController.navigationBar.isHidden = true
              
        //создаем таббар контроллер
        let tabBarController = UITabBarController()
        
        //у каждого из 2 вьюконтроллеров задаем свойства для отображения в таббаре
        navigationHabitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "habits_tab_icon"), tag: 0)
        navigationInfoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(named: "SF Symbol info"), tag: 1)
        tabBarController.tabBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)

              
        //вкладываем оба навигэйшн вьюконтроллера в таббарконтроллер
        let controllers = [navigationHabitsViewController, navigationInfoViewController]
        tabBarController.viewControllers = controllers
        
        //выставляем контроллер, который будет выдаваться на старте
        tabBarController.selectedIndex = 0
        
        
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        
        return true
    }


}

