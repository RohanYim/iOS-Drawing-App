//
//  OutlineShape.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/6/22.
//

import UIKit

class OutlineShape: Shape{
    
    required init(origin: CGPoint, color: UIColor){
        super.init(origin: origin, color: color)
    }
    
    
    override func draw() {}
    
    override func contains(point: CGPoint) -> Bool {
        fatalError("IMPLEMENT THIS")
        
    }
    
    
}
