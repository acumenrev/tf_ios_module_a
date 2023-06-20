//
//  LoginSuccessViewController.swift
//  
//
//  Created by AL-TVO163 on 19/06/2023.
//

import UIKit
import Reusable

class LoginSuccessViewController: UIViewController, ViewModelBased, StoryboardBased {
    typealias ViewModelType = LoginnSuccessViewModel
    
    var viewModel : LoginnSuccessViewModel!
    

    @IBOutlet private weak var lblCenter : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblCenter.text = viewModel.message
    }
}
