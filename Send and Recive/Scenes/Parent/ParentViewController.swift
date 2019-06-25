//
//  ParentViewController.swift
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

protocol ParentDisplayLogic: class
{
  func displaySomething(viewModel: Parent.Something.ViewModel)
  func displayGreeting(viewModel:Parent.TellChild.ViewModel)
}

class ParentViewController: UIViewController, ParentDisplayLogic
{

  var worker:ParentWorker?
  var interactor: ParentBusinessLogic?
  var router: (NSObjectProtocol & ParentRoutingLogic & ParentDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ParentInteractor()
    let presenter = ParentPresenter()
    let router = ParentRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  
  }
   override func viewWillAppear(_ animated: Bool) {
      doSomething()
    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func onTapGetDataBtn(_ sender: Any) {
        tellChild()
        worker?.doSomeWork()
       
     }
    
    func tellChild()
    {
        var serverData:ServerData?
        let title = serverData?.title
        print(title as Any)
        let name = textField.text!
        let request = Parent.TellChild.Request(title: name)
        interactor?.tellChild(request: request)
    }
    
    func doSomething()
    {
    let request = Parent.Something.Request()
    interactor?.doSomething(request: request)
    }
  
    func displayGreeting(viewModel: Parent.TellChild.ViewModel) {
         router?.routeToSomewhere(segue: nil)
    }
    
    func displaySomething(viewModel: Parent.Something.ViewModel)
    {
     label.text = viewModel.greeting
    
    //nameTextField.text = viewModel.name
  
  }
   
    

}
