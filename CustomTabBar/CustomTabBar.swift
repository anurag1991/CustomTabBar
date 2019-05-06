//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Anurag Yadev on 5/6/19.
//  Copyright © 2019 Tempus Flow. All rights reserved.
//

import UIKit

class CustomTabBar: UIViewController {
    
    /// Selected Index Of the Controller
    var selectedIndex: Int = 0
    /// Array of ViewController
    var viewControllers: [UIViewController]!
    
    /// ContentView to provide refrence to the view added.
    @IBOutlet weak var contentView: UIView!
    /// Array Holds all buttons on Custom TabBar
    @IBOutlet var buttons: [UIButton]!
    
    /// Brands view Controller
    lazy var brandsViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let brandsviewController = storyboard.instantiateViewController(withIdentifier: "BrandsViewController") as! BrandsViewController
        let navigationCOntroller = UINavigationController(rootViewController: brandsviewController)
        navigationCOntroller.isNavigationBarHidden = true
        return navigationCOntroller
    }()
    
    /// Taps View Controller
    lazy var tapsViewController: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tapsViewController = storyboard.instantiateViewController(withIdentifier: "TapsViewController") as! TapsViewController
        let navigationCOntroller = UINavigationController(rootViewController: tapsViewController)
        navigationCOntroller.isNavigationBarHidden = true

        return navigationCOntroller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupDefaultViewController()
    }

   private func setupDefaultViewController() {
        
        viewControllers = [brandsViewController, tapsViewController]
        buttons[selectedIndex].setTitleColor(.orange, for: .normal)
        didPressTab(buttons[selectedIndex])
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        
        let previousIndex = selectedIndex
            selectedIndex = sender.tag
        
        buttons[previousIndex].setTitleColor(.white, for: .normal)
        
        let previousVC = viewControllers[previousIndex]
          removePreviousVC(previousVC: previousVC)
        
        sender.setTitleColor(.orange, for: .normal)
        
        let selectedVC = viewControllers[selectedIndex]
          addViewControllerAsChildViewController(child: selectedVC)
    }
    
  private  func removePreviousVC( previousVC: UIViewController)  {
        
        if let navigationVC = previousVC as? UINavigationController {
            navigationVC.popToRootViewController(animated: false)
        }
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
    }
    
    private func addViewControllerAsChildViewController(child: UIViewController) {
        child.view.frame = contentView.bounds
        addChild(child)
        contentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
}

