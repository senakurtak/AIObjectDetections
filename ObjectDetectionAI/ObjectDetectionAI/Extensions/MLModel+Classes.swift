//
//  MLModel+Classes.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import Vision

extension MLModel {
    var classes: [String] {
        guard let userDefined = modelDescription.metadata[MLModelMetadataKey.creatorDefinedKey] as? [String : String] else {
            print("Failed to retrieve mlModel creatorDefinedKey.")
            return []
        }
        return userDefined["classes"]?.components(separatedBy: ",") ?? []
    }
}
