//
//  File.swift
//  
//
//  Created by AL-TVO163 on 19/06/2023.
//

import Foundation
import RxSwift
import RxFlow
import RxCocoa


class LoginnSuccessViewModel : ViewModel, Stepper {
    
    let steps = PublishRelay<Step>()
    
    let message : String
    
    init(message: String) {
        self.message = message
    }
}
