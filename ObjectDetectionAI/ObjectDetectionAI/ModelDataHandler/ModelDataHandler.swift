//
//  ModelDataHandler.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import Vision

protocol ModelDataHandler {
    func runModel(onFrame pixelBuffer: CVPixelBuffer, completion: @escaping ((Result?) -> ()))
}
