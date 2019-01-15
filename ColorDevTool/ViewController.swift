//
//  ViewController.swift
//  ColorDevTool
//
//  Created by Daniel Bonates on 14/01/19.
//  Copyright © 2019 Daniel Bonates. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    @IBOutlet weak var rColor: NSTextField!
    @IBOutlet weak var gColor: NSTextField!
    @IBOutlet weak var bColor: NSTextField!
    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var outputField: NSTextField!
    @IBOutlet weak var watchOutput: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBAction func saveAction(_ sender: Any) {
        
        
        let color = colorToAdd
        append(color)
        
        
    }
    
    var colors = [NSColor]() {
        didSet {
            print(colors.count)
            collectionView.reloadData()
        }
    }
    
    var colorToAdd: NSColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Item"))
        configureCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self

        
        rColor.delegate = self
        gColor.delegate = self
        bColor.delegate = self
        
        updateColorFields()
        updateOutput()
        
    }

    @IBAction func colorChanged(_ sender: NSColorWell) {
        
        colorToAdd = sender.color
        
        updateColorFields()
        updateOutput()
        
    }
    
    func append(_ color: NSColor) {
        
        if !colors.contains(color) {
            colors.append(color)
        }
        
        
        NSColorPanel.shared.orderOut(nil)
        colorWell.deactivate()
    }
    
    func updateColorFields() {
        rColor.stringValue = "\(colorWell.color.redComponent.decimals(3))"
        gColor.stringValue = "\(colorWell.color.greenComponent.decimals(3))"
        bColor.stringValue = "\(colorWell.color.blueComponent.decimals(3))"
    }
    
    func controlTextDidChange(_ obj: Notification) {
        updateColorWell()
        colorToAdd = colorWell.color
    }
    
    func updateColorWell() {
        
        let color = NSColor(calibratedRed: rColor.stringValue.floatValue, green: gColor.stringValue.floatValue, blue: bColor.stringValue.floatValue, alpha: 1.0)
        
        colorWell.color = color
        
        updateOutput()
        
       colorToAdd = color
        
    }
    
    
    fileprivate func configureCollectionView() {
        // 1
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 50.0, height: 50.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
    }
    
    func updateOutput() {
        outputField.stringValue = "NSColor(calibratedRed: \(rColor.stringValue), green: \(gColor.stringValue), blue: \(bColor.stringValue), alpha: 1.0)"
        
        watchOutput.stringValue = "[SKColor colorWithRed:\(rColor.stringValue) green:\(gColor.stringValue) blue:\(bColor.stringValue) alpha:1];"
        
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("Item"), for: indexPath) as! CollectionViewItem
        
        cell.bgColor = colors[indexPath.item]
        
        return cell
    }
    
}

extension String {
    var floatValue: CGFloat {
        let finalFloat = CGFloat((self as NSString).floatValue)
        
        return round(finalFloat * 1000) / 1000
    }
}

extension CGFloat {
    func decimals(_ decimalPlaces: Int = 2) -> CGFloat {
        let factor = pow(CGFloat(10), CGFloat(decimalPlaces))
        return (self * factor).rounded() / factor
    }
}


class ListingItem: NSCollectionViewItem {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
    }
    
}
