//
//  CollectionViewItem.swift
//  ColorDevTool
//
//  Created by Daniel Bonates on 15/01/19.
//  Copyright © 2019 Daniel Bonates. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var bgView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
        
        bgView.wantsLayer = true
        bgView.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
    var bgColor: NSColor = .gray {
        didSet {
            bgView.layer?.backgroundColor = bgColor.cgColor
        }
    }
    
}
