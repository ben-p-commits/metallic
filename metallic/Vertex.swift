//
//  Vertex.swift
//  metallic
//
//  Created by Ben Palmer on 9/3/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation

struct Vertex {
	var x, y, z: Float
	var r, g, b, a: Float
	
	func floatBuffer() -> [Float] {
		return [x, y, z, r, g, b, a]
	}
	
	
}
