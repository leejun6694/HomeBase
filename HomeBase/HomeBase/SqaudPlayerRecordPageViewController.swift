//
//  SqaudPlayerRecordPageViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 14..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadPlayerRecordPageViewController: UIPageViewController {
    
    weak var positionDelegate: SquadPlayerRecordPageViewControllerDelegate?
    var player: Player!
    var playerRecord: PlayerRecord!
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPositionViewController("Batter")!,
                self.newPositionViewController("Pitcher")!]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        print("page view controller")
        print(player.playerID)
        print(playerRecord.baseOnBalls)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        positionDelegate?.positionPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("page view controller view will appear")

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("page view controller prepare batter")
        if let batterViewController = segue.destination as? BatterViewController {
            batterViewController.record = playerRecord
        }
    }

    
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            
            scrollToViewController(nextViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    fileprivate func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            positionDelegate?.positionPageViewController(self, didUpdatePageIndex: index)
        }
    }

    
    private func newPositionViewController(_ position: String) -> UIViewController? {
        if position == "Batter" {
            let contentViewController = storyboard?.instantiateViewController(
                withIdentifier: "BatterViewController") as! BatterViewController
            contentViewController.record = playerRecord
            return contentViewController
        } else {
            let contentViewController = storyboard?.instantiateViewController(
                withIdentifier: "PitcherViewController") as! PitcherViewController
            contentViewController.record = playerRecord
            return contentViewController
        }
        
    }
}

extension SquadPlayerRecordPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]

            }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]

    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }

}

extension SquadPlayerRecordPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            positionDelegate?.positionPageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }
}

protocol SquadPlayerRecordPageViewControllerDelegate: class {
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func positionPageViewController(_ tutorialPageViewController: SquadPlayerRecordPageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func positionPageViewController(_ tutorialPageViewController:SquadPlayerRecordPageViewController,
                                    didUpdatePageIndex index: Int)

}
