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
		let scene = SCNScene(named: "art.scnassets/thy+nod022317_0013.scn")!

		// create and add a camera to the scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		scene.rootNode.addChildNode(cameraNode)

		// place the camera
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
		cameraNode.camera?.zNear = 2
		cameraNode.camera?.zFar = 20


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
		let thyroidNod = scene.rootNode.childNode(withName: "throidNod", recursively: true)
		thyroidNod?.position = SCNVector3(x: 0, y: 120, z: 0)

		// set the scene to the view
		scnView.scene = scene

		recursivlyPrint(node: scene.rootNode)
		revert()

		// allows the user to manipulate the camera
		scnView.allowsCameraControl = true

		// show statistics such as fps and timing information
		scnView.showsStatistics = true

		// configure the view
		scnView.backgroundColor = UIColor.black

		// add a tap gesture recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		scnView.addGestureRecognizer(tapGesture)

		animations = [self.growLMidBaseBack, { self.revert(); self.growLMidBaseFront() }, { self.revert(); self.growLMidBaseSide() }, { self.revert(); self.growLMidNoduleControl() }, self.revert]
	}

	var animations: [() -> ()] = []
	var currentAnimation: Int = 0

	var scnView: SCNView {
		return view as! SCNView
	}

	func growLMidBaseBack() {
		let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		let skeleton = throidNod.skinner!.skeleton!
		let lMidBaseBack = skeleton.childNode(withName: "L_Mid_BaseBack", recursively: true)!
		lMidBaseBack.scale = SCNVector3(x: 2, y: 2, z: 2)
		let lMidNodeCounter = skeleton.childNode(withName: "L_Mid_nodCounter", recursively: true)!
		lMidNodeCounter.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
	}

	func growLMidBaseFront() {
		let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		let skeleton = throidNod.skinner!.skeleton!
		let lMidBaseFront = skeleton.childNode(withName: "L_Mid_BaseFrnt", recursively: true)!
		lMidBaseFront.scale = SCNVector3(x: 2, y: 2, z: 2)
		let lMidNodeCounter = skeleton.childNode(withName: "L_Mid_nodCounter", recursively: true)!
		lMidNodeCounter.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
	}

	func growLMidBaseSide() {
		let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		let skeleton = throidNod.skinner!.skeleton!
		let lMidBaseSide = skeleton.childNode(withName: "L_Mid_BaseSide", recursively: true)!
		lMidBaseSide.scale = SCNVector3(x: 2, y: 2, z: 2)
		let lMidNodeCounter = skeleton.childNode(withName: "L_Mid_nodCounter", recursively: true)!
		lMidNodeCounter.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
	}

	func growLMidNoduleControl() {
		let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		let skeleton = throidNod.skinner!.skeleton!
		let lMidNoduleControl = skeleton.childNode(withName: "L_Mid_nodCtrl", recursively: true)!
		lMidNoduleControl.scale = SCNVector3(x: 3, y: 3, z: 3)
	}

	func growLMidNoduleBulge() {
		let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		let skeleton = throidNod.skinner!.skeleton!
		let lMidNoduleBulge = skeleton.childNode(withName: "L_Mid_nodBulge", recursively: true)!
		lMidNoduleBulge.scale = SCNVector3(x: 2, y: 2, z: 2)
	}

	func revert() {
    let thyroidOrganic = scnView.scene!.rootNode.childNode(withName: "thyroid-organic", recursively: true)!
    let skeleton = thyroidOrganic.skinner!.skeleton!
    let rootSkel = skeleton.childNode(withName: "thyroidRoot", recursively: true)!
    let lRootSkel = rootSkel.childNode(withName: "L_root", recursively: true)!
    let lTopGlandBulge = lRootSkel.childNode(withName: "L_top_counterScale", recursively: true)!
    
//		let thyroidRoot = scnView.scene!.rootNode.childNode(withName: "thyroid-organic", recursively: true)!
//		let skeleton = thyroidRoot.skinner!.skeleton!
//		let lTopGlandBulge = skeleton.childNode(withName: "L_top_gland_Bulge", recursively: true)!
//		lTopGlandBulge.scale = SCNVector3(x: 0, y: 0, z: 0)
		//let throidNod = scnView.scene!.rootNode.childNode(withName: "thyroidNod", recursively: true)!
		//let skeleton = throidNod.skinner!.skeleton!
		//let lMidBaseBack = skeleton.childNode(withName: "L_Mid_BaseBack", recursively: true)!
		//lMidBaseBack.scale = SCNVector3(x: 1, y: 1, z: 1)
		//let lMidBaseFront = skeleton.childNode(withName: "L_Mid_BaseFrnt", recursively: true)!
		//lMidBaseFront.scale = SCNVector3(x: 1, y: 1, z: 1)
		//let lMidBaseSide = skeleton.childNode(withName: "L_Mid_BaseSide", recursively: true)!
		//lMidBaseSide.scale = SCNVector3(x: 1, y: 1, z: 1)
		//let lMidNodeCounter = skeleton.childNode(withName: "L_Mid_nodCounter", recursively: true)!
		//lMidNodeCounter.scale = SCNVector3(x: 1, y: 1, z: 1)
		//let lMidNoduleControl = skeleton.childNode(withName: "L_Mid_nodCtrl", recursively: true)!
		//lMidNoduleControl.scale = SCNVector3(x: 0, y: 0, z: 0)
		//let lMidNoduleBulge = skeleton.childNode(withName: "L_Mid_nodBulge", recursively: true)!
		//lMidNoduleBulge.scale = SCNVector3(x: 2, y: 2, z: 2)
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
			animations[currentAnimation]()
			currentAnimation += 1
			currentAnimation = currentAnimation % animations.count

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

func recursivlyPrint(node: SCNNode) {
	if let name = node.name {
		print("node: \(name), scale: \(node.scale)")
	}
	for child in node.childNodes {
		recursivlyPrint(node: child)
	}
}
