//
//  GameViewController.swift
//  SceneKitTest
//
//  Created by Daniel Tartaglia on 11/30/16.
//  Copyright © 2016 Haneke Design. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    //let scene = SCNScene(named: "art.scnassets/sphereRigged.dae")!
    let scene = SCNScene(named: "art.scnassets/ship.scn")!
    
    // create and add a camera to the scene
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    scene.rootNode.addChildNode(cameraNode)
    
    // place the camera
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 500)
    cameraNode.camera?.zNear = 100
    cameraNode.camera?.zFar = 1000
    
    
    // create and add a light to the scene
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .omni
    lightNode.position = SCNVector3(x: 0, y: 1000, z: 500)
    scene.rootNode.addChildNode(lightNode)
    
    let lightNode2 = SCNNode()
    lightNode2.light = SCNLight()
    lightNode2.light!.type = .omni
    lightNode2.position = SCNVector3(x: 0, y: 1000, z: -500)
    scene.rootNode.addChildNode(lightNode2)
    
    // create and add an ambient light to the scene
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = .ambient
    ambientLightNode.light!.color = UIColor.lightGray
    ambientLightNode.light!.intensity = 500
    scene.rootNode.addChildNode(ambientLightNode)
    
    // retrieve the ship node
    let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
    ship.position = SCNVector3(x: 0, y: 120, z: 0)
    
    // animate the 3d object
    ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
    
    // retrieve the SCNView
    let scnView = self.view as! SCNView
    
    // set the scene to the view
    scnView.scene = scene
    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = true
    
    // show statistics such as fps and timing information
    scnView.showsStatistics = true
    
    // configure the view
    scnView.backgroundColor = UIColor.black
    
    // add a tap gesture recognizer
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    scnView.addGestureRecognizer(tapGesture)
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // Animation tests
//    let riggedSphereRoot = scene.rootNode.childNode(withName: "RiggedSphereRoot", recursively: true)!.childNodes.first!
//    riggedSphereRoot.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: -2, z: 0, duration: 1)))
    
    let riggedSphere = scene.rootNode.childNode(withName: "RiggedSphere", recursively: true)!
    let skeleton = riggedSphere.skinner!.skeleton!
//    riggedSphere.skinner!.bones.forEach { (bone) in
//      bone.runAction(SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: 0, z: -10, duration: 1)))
//    }
    
    let jointRoot = skeleton.childNode(withName: "Joint_1_root", recursively: true)!
    let joint = jointRoot.childNode(withName: "Joint_1", recursively: true)!
    let jointTip = joint.childNode(withName: "Joint_1_tip", recursively: true)!
    
//    joint.position = SCNVector3(x: 0, y: 0, z: 0)
//    joint.eulerAngles = SCNVector3(x: -180, y: 0, z: 0)
    joint.scale = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
    
    let joint2Root = skeleton.childNode(withName: "Joint_2_root", recursively: true)!
    let joint2 = joint2Root.childNode(withName: "Joint_2", recursively: true)!
    joint2.scale = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
    
    let joint3Root = skeleton.childNode(withName: "Joint_3_root", recursively: true)!
    let joint3 = joint3Root.childNode(withName: "Joint_3", recursively: true)!
    joint3.runAction(SCNAction.scale(to: 3.0, duration: 8))
//    joint3.scale = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
  }
  
  func handleTap(_ gestureRecognize: UIGestureRecognizer) {
    // retrieve the SCNView
    let scnView = self.view as! SCNView
    
    // check what nodes are tapped
    let p = gestureRecognize.location(in: scnView)
    let hitResults = scnView.hitTest(p, options: [:])
    // check that we clicked on at least one object
    if hitResults.count > 0 {
      // retrieved the first clicked object
      let result: AnyObject = hitResults[0]
      
      // get its material
      let material = result.node!.geometry!.firstMaterial!
      
      // highlight it
      SCNTransaction.begin()
      SCNTransaction.animationDuration = 0.5
      
      // on completion - unhighlight
      SCNTransaction.completionBlock = {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        material.emission.contents = UIColor.black
        
        SCNTransaction.commit()
      }
      
      material.emission.contents = UIColor.red
      
      SCNTransaction.commit()
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
}
