//
//  CameraFeedViewController.swift
//  ObjectDetectionAI
//
//  Created by Sena Kurtak on 3.04.2023.
//

import UIKit

class CameraFeedViewController: UIViewController {
    // Storyboard connections
    
    @IBOutlet weak var overlayViewLayer: OverlayView!
    @IBOutlet weak var previewViewLayer: PreviewView!
    @IBOutlet weak var resumeSessionButton: UIButton!
    @IBOutlet weak var cameraLabel: UILabel!
    
    
    // MARK: Controllers that manage functionality
    lazy var cameraFeedManager = CameraFeedManager(previewView: previewViewLayer)
    
    // MARK: View Handling Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraFeedManager.delegate = self
        overlayViewLayer.clearsContextBeforeDrawing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraFeedManager.checkCameraConfigurationAndStartSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraFeedManager.stopSession()
    }

    @IBAction func  ButtonTapped(_ sender: Any) {
        cameraFeedManager.resumeInterruptedSession { (complete) in
            if complete {
                self.resumeSessionButton.isHidden = true
                self.cameraLabel.isHidden = true
            } else {
                self.presentUnableToResumeSessionAlert()
            }
        }
    }
    
    
    func presentUnableToResumeSessionAlert() {
        let alert = UIAlertController(
            title: "Unable to Resume Session",
            message: "There was an error while attempting to resume session.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: CameraFeedManagerDelegate
extension CameraFeedViewController: CameraFeedManagerDelegate {
    @objc func didOutput(pixelBuffer: CVPixelBuffer) {
        // Oberride in sublasses to handle changes
    }
    
    // MARK: Session Handling Alerts
    func sessionRunTimeErrorOccured() {
        // Handles session run time error by updating the UI and providing a button if session can be manually resumed.
        resumeSessionButton.isHidden = false
    }
    
    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {
        // Updates the UI when session is interupted.
        if resumeManually {
            resumeSessionButton.isHidden = false
        }
        else {
            cameraLabel.isHidden = false
        }
    }
    
    func sessionInterruptionEnded() {
        // Updates UI once session interruption has ended.
        if !cameraLabel.isHidden {
            cameraLabel.isHidden = true
        }
        
        if !resumeSessionButton.isHidden {
            resumeSessionButton.isHidden = true
        }
    }
}
