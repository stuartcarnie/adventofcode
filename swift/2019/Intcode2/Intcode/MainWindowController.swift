//
//  MainWindowController.swift
//  Intcode
//
//  Created by Stuart Carnie on 12/21/19.
//  Copyright © 2019 Stuart Carnie. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}

class MyTestSegue: NSStoryboardSegue {
    override init(identifier: NSStoryboardSegue.Identifier, source sourceController: Any, destination destinationController: Any) {
        super.init(identifier: identifier, source: sourceController, destination: destinationController)
    }
    
    override func perform() {
        guard
            let src = sourceController as? NSWindowController,
            let dst = destinationController as? NSViewController
            else { return }
        
        src.contentViewController = dst
    }
}
