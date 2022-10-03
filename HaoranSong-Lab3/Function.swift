//
//  Function.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 9/30/22.
//

import UIKit

class Function {
    static func distance(a:CGPoint,b:CGPoint) -> CGFloat{
        return sqrt(pow(a.x-b.x, 2)+pow(a.y-b.y, 2))
    }
}
