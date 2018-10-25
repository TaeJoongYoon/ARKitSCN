//
//  ViewController.swift
//  ARKitSCN
//
//  Created by Tae joong Yoon on 25/10/2018.
//  Copyright © 2018 Tae joong Yoon. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
  
  @IBOutlet var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Check this device is supported
    guard ARWorldTrackingConfiguration.isSupported else {
      fatalError("""
                ARKit is not available on this device. For apps that require ARKit
                for core functionality, use the `arkit` key in the key in the
                `UIRequiredDeviceCapabilities` section of the Info.plist to prevent
                the app from installing. (If the app can't be installed, this error
                can't be triggered in a production scenario.)
                In apps where AR is an additive feature, use `isSupported` to
                determine whether to show UI for launching AR experiences.
            """) // For details, see https://developer.apple.com/documentation/arkit
    }
    
    // Set the view's delegate
    sceneView.session.delegate = self
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    
    // Create a new scene
    let scene = SCNScene()
    
    // Text
    let textGeometry = SCNText(string: "hello world", extrusionDepth: 1.0)
    let textMaterial = SCNMaterial()
    textMaterial.diffuse.contents = UIColor.black
    textGeometry.materials = [textMaterial]
    
    let textNode = SCNNode(geometry: textGeometry)
    textNode.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
    textNode.scale = SCNVector3(0.02, 0.02, 0.02)
    
    
    // Box
    let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
    let boxMaterial = SCNMaterial()
    boxMaterial.diffuse.contents = UIColor.blue
    
    let boxNode = SCNNode()
    boxNode.geometry = boxGeometry
    boxNode.geometry?.materials = [boxMaterial]
    boxNode.position = SCNVector3(0.0, 0.0, -2.0)
    
    // Add nodes to scene
    scene.rootNode.addChildNode(textNode)
    scene.rootNode.addChildNode(boxNode)
    
    // Set the scene to the view
    sceneView.scene = scene
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = [.horizontal, .vertical]
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  private func resetTracking() {
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = [.horizontal, .vertical]
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate{
  
  // Override to create and configure nodes for anchors added to the view's session.
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    let node = SCNNode()
    
    return node
  }
  
  // Override to create and configure nodes for anchors added to the view's session.
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
  }
  
  // Override to update nodes for anchors added to the view's session.
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    
  }
  
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate{
  func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
    
  }
  
  func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
    
  }
  
  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    
  }
  
  // MARK: - ARSessionObserver
  
  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user.
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay.
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required.
    
  }
  
}

