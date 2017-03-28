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
		let scene = SCNScene(named: "art.scnassets/thyroid_0034.scn")!

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
		lightNode.position = SCNVector3(x: 0, y: 100, z: 500)
		scene.rootNode.addChildNode(lightNode)

		let lightNode2 = SCNNode()
		lightNode2.light = SCNLight()
		lightNode2.light!.type = .omni
		lightNode2.position = SCNVector3(x: 0, y: 100, z: -500)
		scene.rootNode.addChildNode(lightNode2)

		let lightNode3 = SCNNode()
		lightNode2.light = SCNLight()
		lightNode2.light!.type = .omni
		lightNode2.position = SCNVector3(x: 0, y: -100, z: -500)
		scene.rootNode.addChildNode(lightNode3)

		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = .ambient
		ambientLightNode.light!.color = UIColor.lightGray
		if #available(iOS 10.0, *) {
			ambientLightNode.light!.intensity = 1000
		}
		scene.rootNode.addChildNode(ambientLightNode)

		// retrieve the root node
		let thyroidNod = scene.rootNode.childNode(withName: "throidNod", recursively: true)
		thyroidNod?.position = SCNVector3(x: 0, y: 120, z: 0)

		// set the scene to the view
		scnView.scene = scene

		//recursivlyPrint(node: scene.rootNode)
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

		animations = [leftLobeWidth, revert, rightLobeWidth, revert, leftTopNodule, revert]
	}

	var animations: [() -> ()] = []
	var currentAnimation: Int = 0

	var scnView: SCNView {
		return view as! SCNView
	}

	func revert() {
		let thyroidMesh = scnView.scene!.rootNode.childNode(withName: "thyroidMesh", recursively: true)!
		let skeleton = thyroidMesh.skinner!.skeleton!

		let lLobeWhole = skeleton.childNode(withName: "L_LobeWhole", recursively: true)!
		lLobeWhole.position = SCNVector3(x: 1.14, y: 0.0, z: -0.01)
		lLobeWhole.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let lTopLobe = skeleton.childNode(withName: "L_top_Lobe", recursively: true)!
		lTopLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let lMidLobe = skeleton.childNode(withName: "L_mid_Lobe", recursively: true)!
		lMidLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let lBtmLobe = skeleton.childNode(withName: "L_btm_Lobe", recursively: true)!
		lBtmLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let lTopCounter = skeleton.childNode(withName: "L_top_counter", recursively: true)!
		lTopCounter.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let lMidCounter = skeleton.childNode(withName: "L_mid_counter", recursively: true)!
		lMidCounter.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rLobeWhole = skeleton.childNode(withName: "R_LobeWhole", recursively: true)!
		rLobeWhole.position = SCNVector3(x: -1.14, y: 0.0, z: -0.01)
		rLobeWhole.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rTopLobe = skeleton.childNode(withName: "R_top_Lobe", recursively: true)!
		rTopLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rMidLobe = skeleton.childNode(withName: "R_mid_Lobe", recursively: true)!
		rMidLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rBtmLobe = skeleton.childNode(withName: "R_btm_Lobe", recursively: true)!
		rBtmLobe.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rTopCounter = skeleton.childNode(withName: "R_top_counter", recursively: true)!
		rTopCounter.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let rMidCounter = skeleton.childNode(withName: "R_mid_counter", recursively: true)!
		rMidCounter.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
		
		let isthmusGlandScale = skeleton.childNode(withName: "isthmus_glandScale", recursively: true)!
		isthmusGlandScale.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)

		let isthmusNodScale = skeleton.childNode(withName: "isthmus_nodScale", recursively: true)!
		isthmusNodScale.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
		isthmusNodScale.opacity = 1

		let lTopGlandScale = skeleton.childNode(withName: "L_top_glandScale", recursively: true)!
		lTopGlandScale.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
		lTopGlandScale.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
		lTopGlandScale.rotation = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 0.0)

		let lTopNodScale = skeleton.childNode(withName: "L_top_nodScale", recursively: true)!
		lTopNodScale.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
		lTopNodScale.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
		lTopNodScale.rotation = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
		lTopNodScale.opacity = 1
	}
	
	func leftLobeWidth() {
		let thyroidMesh = scnView.scene!.rootNode.childNode(withName: "thyroidMesh", recursively: true)!
		let skeleton = thyroidMesh.skinner!.skeleton!

		let lLobeWhole = skeleton.childNode(withName: "L_LobeWhole", recursively: true)!
		lLobeWhole.position = SCNVector3(x: 2.5, y: 0.0, z: -0.01)
		lLobeWhole.scale = SCNVector3(x: 1.9, y: 1.4, z: 1.4)

		let lTopLobe = skeleton.childNode(withName: "L_top_Lobe", recursively: true)!
		lTopLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let lMidLobe = skeleton.childNode(withName: "L_mid_Lobe", recursively: true)!
		lMidLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let lBtmLobe = skeleton.childNode(withName: "L_btm_Lobe", recursively: true)!
		lBtmLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let lTopCounter = skeleton.childNode(withName: "L_top_counter", recursively: true)!
		lTopCounter.scale = SCNVector3(x: 1 / lLobeWhole.scale.x * 1 / lTopLobe.scale.x, y: 1 / lLobeWhole.scale.y * 1 / lTopLobe.scale.y, z: 1 / lLobeWhole.scale.z * 1 / lTopLobe.scale.z)

		let lMidCounter = skeleton.childNode(withName: "L_mid_counter", recursively: true)!
		lMidCounter.scale = SCNVector3(x: 1 / lLobeWhole.scale.x * 1 / lMidLobe.scale.x, y: 1 / lLobeWhole.scale.y * 1 / lMidLobe.scale.y, z: 1 / lLobeWhole.scale.z * 1 / lMidLobe.scale.z)
	}
	
	func rightLobeWidth() {
		let thyroidMesh = scnView.scene!.rootNode.childNode(withName: "thyroidMesh", recursively: true)!
		let skeleton = thyroidMesh.skinner!.skeleton!

		let rLobeWhole = skeleton.childNode(withName: "R_LobeWhole", recursively: true)!
		rLobeWhole.position = SCNVector3(x: -0.22, y: 0.0, z: -0.01)
		rLobeWhole.scale = SCNVector3(x: 1.9, y: 1.4, z: 1.4)

		let rTopLobe = skeleton.childNode(withName: "R_top_Lobe", recursively: true)!
		rTopLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let rMidLobe = skeleton.childNode(withName: "R_mid_Lobe", recursively: true)!
		rMidLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let rBtmLobe = skeleton.childNode(withName: "R_btm_Lobe", recursively: true)!
		rBtmLobe.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)

		let rTopCounter = skeleton.childNode(withName: "R_top_counter", recursively: true)!
		rTopCounter.scale = SCNVector3(x: 1 / rLobeWhole.scale.x * 1 / rTopLobe.scale.x, y: 1 / rLobeWhole.scale.y * 1 / rTopLobe.scale.y, z: 1 / rLobeWhole.scale.z * 1 / rTopLobe.scale.z)

		let rMidCounter = skeleton.childNode(withName: "R_mid_counter", recursively: true)!
		rMidCounter.scale = SCNVector3(x: 1 / rLobeWhole.scale.x * 1 / rMidLobe.scale.x, y: 1 / rLobeWhole.scale.y * 1 / rMidLobe.scale.y, z: 1 / rLobeWhole.scale.z * 1 / rMidLobe.scale.z)
}

	func leftTopNodule() {
		let thyroidMesh = scnView.scene!.rootNode.childNode(withName: "thyroidMesh", recursively: true)!
		let skeleton = thyroidMesh.skinner!.skeleton!

		let lTopGlandScale = skeleton.childNode(withName: "L_top_glandScale", recursively: true)!
		lTopGlandScale.position = SCNVector3(x: 0.0, y: 0.0, z: 1.0)
		lTopGlandScale.scale = SCNVector3(x: 6.0, y: 6.0, z: 6.0)
		lTopGlandScale.rotation = SCNVector4(x: 0.0, y: 0.305, z: 0.0, w: 0.0)

		let lTopNodScale = skeleton.childNode(withName: "L_top_nodScale", recursively: true)!
		lTopNodScale.position = SCNVector3(x: 0.0, y: -0.2, z: 0.0)
		lTopNodScale.scale = SCNVector3(x: 5.0, y: 5.0, z: 5.5)
		lTopNodScale.rotation = SCNVector4(x: 0.0, y: 0.079, z: 0.0, w: 0.0)
		lTopNodScale.opacity = 0
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

}

var visited: [SCNNode: Bool] = [:]

func recursivlyPrint(node: SCNNode, level: Int = 0) {
	if visited[node] == true { return }
	visited[node] = true
	if let name = node.name {
		print("\(level) skinner? \(node.skinner != nil ? "yes" : "no"), scale: \(node.scale), node: \(name)")
	}
	if let skeleton = node.skinner?.skeleton {
		for child in skeleton.childNodes {
			recursivlyPrint(node: child, level: level + 1)
		}
	}
	else {
		for child in node.childNodes {
			recursivlyPrint(node: child, level: level + 1)
		}
	}
}
