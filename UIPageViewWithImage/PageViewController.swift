//
//  PageViewController.swift
//  UIPageViewWithImage
//
//  Created by Artem Karmaz on 3/16/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private (set) lazy var controllers: [UIViewController] = {
        return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "First"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Second"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Third"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Fourth"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Fifth")
        ]
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = .clear
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0.8, blue: 0.5, alpha: 0.8)


        if let first = controllers.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
            dataSource = self
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    // MARK:- PageView Delegates
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard controllers.count > previousIndex else { return nil }
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard controllers.count != nextIndex else { return nil }
        guard controllers.count > nextIndex else { return nil }
        return controllers[nextIndex]
    }
}

extension PageViewController {
    
    // MARK:- PageView Helpers
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
        let firstViewControllerIndex = controllers.index(of: firstViewController) else { return 0 }
        return firstViewControllerIndex
    }
    
    
}
