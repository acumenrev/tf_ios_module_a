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
import tf_ios_app_flows

public class LoginViewModel : Stepper, ViewModel {
    public let steps = PublishRelay<Step>()
    
    public init() {
        
    }
    
    public func loginnSuccess() {
        self.steps.accept(FlowAStepper.loginSuccess(message: "Login Success"))
    }
    
     func loginnFailed() {
        self.steps.accept(FlowAStepper.loginFailed(message: "Login Failed"))
    }
}
