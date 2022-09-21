//
//  TabBarController.swift
//  MyHabits
//
//  Created by kosmokos I on 21.09.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: Properties
    
    var firstTabNavidationController: UINavigationController!
    var secondTabNavigationController: UINavigationController!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Methods
    
    private func setupUI() {
        
        firstTabNavidationController = UINavigationController.init(rootViewController: HabitsViewController())
        secondTabNavigationController = UINavigationController.init(rootViewController: InfoViewController())
        
        viewControllers = [firstTabNavidationController, secondTabNavigationController]
        
        let item1 = UITabBarItem(title: "Привычки", image: #imageLiteral(resourceName: "habits_icon"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)
        
        firstTabNavidationController.tabBarItem = item1
        secondTabNavigationController.tabBarItem = item2
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        UITabBar.appearance().backgroundColor = (#colorLiteral(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 0.8))
    }
    
}
