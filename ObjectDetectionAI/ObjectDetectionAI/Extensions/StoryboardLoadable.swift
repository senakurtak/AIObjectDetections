//
//  StoryboardLoadable.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import UIKit

protocol StoryboardLoadable: class {
    static var storyboardName: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    static func instance() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError(String(describing: Self.self) + "not found in \(storyboardName)")
        }
        
        return viewController
    }
}
