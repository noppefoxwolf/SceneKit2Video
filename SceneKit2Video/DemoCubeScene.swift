//
//  DemoCubeScene.swift
//  SceneKit2Video
//
//  Created by Lacy Rhoades on 7/27/17.
//  Copyright © 2017 Lacy Rhoades. All rights reserved.
//

import SceneKit

class DemoCubeScene: SCNScene {
    var isDone: Bool {
        return self.rotationsSoFar >= self.rotations
    }
    
    private(set) var rotations: Int = 1
    private var rotationsSoFar: Int = 0
    private var rotationDuration: TimeInterval = 3.0
    
    var duration: TimeInterval {
        return self.rotationDuration * TimeInterval(self.rotations)
    }
    
    convenience init(rotations: Int) {
        self.init()
        
        precondition(rotations >= 1)
        
        self.rotations = rotations
        
        self.background.contents = UIColor.black
        
        let redMaterial = SCNMaterial()
        
        let cube = SCNBox(width: 35, height: 35, length: 35, chamferRadius: 0)
        cube.materials = [redMaterial]
        let cubeGeometryNode = SCNNode(geometry: cube)
        cubeGeometryNode.position = SCNVector3Make(0.0, 0.0, -75.0)
        self.rootNode.addChildNode(cubeGeometryNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zNear = 0
        cameraNode.camera?.zFar = 1000
        cameraNode.position = SCNVector3Make(0, 0, 0)
        cameraNode.eulerAngles = SCNVector3Make(0.0, 0.0, 0.0)
        
        let cameraBoxNode = SCNNode()
        cameraBoxNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(cameraBoxNode)
        
        cubeGeometryNode.runAction(
            SCNAction.repeatForever(
                SCNAction.sequence(
                    [
                        SCNAction.rotateBy(x: 0.0, y: 2 * CGFloat.pi, z: 2 * CGFloat.pi, duration: self.rotationDuration),
                        SCNAction.run({ (node) in
                            self.rotationsSoFar += 1
                        })
                    ]
                )
            )
        )
    }
}
