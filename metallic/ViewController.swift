//
//  ViewController.swift
//  metallic
//
//  Created by Ben Palmer on 9/3/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {
	
	var device: MTLDevice!
	var mlayer: CAMetalLayer!
	var pipeline_state: MTLRenderPipelineState!
	var command_queue: MTLCommandQueue!
	
	var timer: CADisplayLink!
	
	var objectToDraw: Triangle!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		device = MTLCreateSystemDefaultDevice()
		
		mlayer = CAMetalLayer()
		mlayer.device = device
		mlayer.pixelFormat = .bgra8Unorm
		mlayer.framebufferOnly = true
		mlayer.frame = view.layer.frame
		view.layer.addSublayer(mlayer)
		
		objectToDraw = Triangle(device: device)
		
		let default_lib = device.makeDefaultLibrary()!
		let fragment_prog = default_lib.makeFunction(name: "basic_fragment")
		let vertex_prog = default_lib.makeFunction(name: "basic_vertex")
		
		let pipeline_descriptor = MTLRenderPipelineDescriptor()
		
		pipeline_descriptor.vertexFunction = vertex_prog
		pipeline_descriptor.fragmentFunction = fragment_prog
		pipeline_descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		
		pipeline_state = try! device.makeRenderPipelineState(descriptor: pipeline_descriptor)
		command_queue = device.makeCommandQueue()
		
		timer = CADisplayLink(target: self, selector: #selector(ViewController.gameloop))
		timer.add(to: .main, forMode: .default)
	}
	
	func render() {
		guard let drawable = mlayer?.nextDrawable() else { return }
		objectToDraw.render(commandQueue: command_queue, pipelineState: pipeline_state, drawable: drawable, clearColor: nil)
	}
	
	@objc func gameloop() {
		self.render()
	}
}

