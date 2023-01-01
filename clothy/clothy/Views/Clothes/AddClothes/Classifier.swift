//
//  Classifier.swift
//  clothy
//
//  Created by haithem ghattas on 21/11/2022.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: ClothyCoreML(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        
      
        
        
        if let firstResult = results.first {
            print(firstResult)
            print("-------------")
            print(firstResult.confidence)
            print("-------------")


            print(firstResult.identifier)
            if(firstResult.confidence < 0.70){
                
                self.results = "AI could not define the outfit Type"

            }else {
                self.results = firstResult.identifier

            }
        }
    
        
    }
    
}

