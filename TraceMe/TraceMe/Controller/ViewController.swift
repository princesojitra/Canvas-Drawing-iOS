//
//  ViewController.swift
//  TraceMe
//
//  Created by Prince Sojitra on 14/09/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewCanvas: Canvas!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCanvas.setNeedsDisplay()
    }
    
    @IBAction func drawClicked(_ sender: Any) {
        self.viewCanvas.startDrawing()
    }
    
    @IBAction func eraseDrawingClicked(_ sender: Any) {
        self.viewCanvas.clear()
    }
    
    @IBAction func playAnimationClicked(_ sender: Any) {
        self.viewCanvas.playAnimation()
    }
}
