//
//  MainViewController.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import UIKit
import AVKit
import Vision

final class MainViewController: CameraFeedViewController {
    
    @IBOutlet weak var visualEfectLayerView: UIVisualEffectView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    @IBOutlet weak var fpsLabel: UILabel!
    private var modelDataHandler: ModelDataHandler?
    private let fpsCounter = FPSCounter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fpsCounter.start()
        closeButton.isHidden = true
        cameraLabel.isHidden = true
        resumeSessionButton.isHidden = true
        navigationItem.backBarButtonItem?.isHidden = true
    }
    
    @IBAction func startDetection(_ sender: Any) {
        modelDataHandler = TFModelDataHandler(modelFileInfo: MobileNetSSD.modelInfo, labelsFileInfo: MobileNetSSD.labelsInfo)
        changeVisibility(true)
        title = "Detecting Object with Tensorflow"
        
    }
    
    private func changeVisibility(_ isHidden: Bool) {
        fpsLabel.isHidden = !isHidden
        visualEfectLayerView.isHidden = isHidden
        closeButton.isHidden = !isHidden
    }
    
    private func updateFPSLabel() {
        DispatchQueue.main.async {
            self.fpsCounter.frameCompleted()
            self.fpsLabel.text = String(format: "%.1f FPS\nFrame interval: %d", self.fpsCounter.fps, self.cameraFeedManager .frameInterval)
        }
    }
    @IBAction func closeButtonTap(_ sender: Any) {
        modelDataHandler = nil
        changeVisibility(false)
        overlayViewLayer.clear()
        title = nil
        print("close button tapped")
        
    }
    
    // MARK: Override
    override func didOutput(pixelBuffer: CVPixelBuffer) {
        updateFPSLabel()
        
        modelDataHandler?.runModel(onFrame: pixelBuffer, completion: { (result) in
            guard let result = result else { return }
            let width = CVPixelBufferGetWidth(pixelBuffer)
            let height = CVPixelBufferGetHeight(pixelBuffer)
            let imageSize = CGSize(width: CGFloat(width), height: CGFloat(height))
            DispatchQueue.main.async {
                // Draws the bounding boxes and displays class names and confidence scores.
                self.overlayViewLayer.drawAfterPerformingCalculations(onInferences: result.inferences, withImageSize: imageSize)
            }
        })
    }
    
}
