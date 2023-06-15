//
//  FSPCounter.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import Foundation
import QuartzCore

class FPSCounter {
    private(set) public var fps: Double = 0
    
    var frames = 0
    var startTime: CFTimeInterval = 0
    
    func start() {
        frames = 0
        startTime = CACurrentMediaTime()
    }
    
    func frameCompleted() {
        frames += 1
        let now = CACurrentMediaTime()
        let elapsed = now - startTime
        if elapsed >= 0.01 {
            fps = Double(frames) / elapsed
            if elapsed >= 1 {
                frames = 0
                startTime = now
            }
        }
    }
}

