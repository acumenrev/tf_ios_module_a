//
//  AppFlow.swift
//  FlowADemo
//
//  Created by AL-TVO163 on 19/06/2023.
//

import Foundation
import RxSwift
import RxFlow
import RxCocoa
import tf_ios_module_a
import tf_ios_app_flows
import UIKit

enum AppStep : Step {
    case start
}

class AppFlows : Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        
        switch appStep {
        case .start:
            let moduleAFlow = ModuleAFlow.init(service: "Service")
            Flows.use(moduleAFlow, when: .ready) { flowRoot in
                self.rootViewController.present(flowRoot, animated: true)
            }
            return .one(flowContributor: .contribute(withNextPresentable: moduleAFlow, withNextStepper: ModuleAStepper()))
        }
    }
    
}


class AppStepper : Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppStep.start
    }
}
