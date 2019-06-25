//
//  ChildRouter.swift
//  Send and Recive
//
//  Created by Bhargavi on 20/06/19.
//  Copyright (c) 2019 Amrutha. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ChildRoutingLogic
{
  func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ChildDataPassing
{
  var dataStore: ChildDataStore? { get }
}

class ChildRouter: NSObject, ChildRoutingLogic, ChildDataPassing
{
  weak var viewController: ChildViewController?
  var dataStore: ChildDataStore?
  
  // MARK: Routing
  
  func routeToSomewhere(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! ParentViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
      navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToSomewhere(source: ChildViewController, destination: ParentViewController)
  {
    source.show(destination, sender: nil)
  }
  
//   MARK: Passing data
  
  func passDataToSomewhere(source: ChildDataStore, destination: inout ParentDataStore)
  {
    destination.name = source.name
  }
}
