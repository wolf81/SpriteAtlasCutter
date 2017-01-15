//
//  ImageProcessor.swift
//  SpriteAtlasCutter
//
//  Created by Wolfgang Schreurs on 14/01/2017.
//  Copyright © 2017 Wolftrail. All rights reserved.
//

import Foundation
import AppKit

class ImageProcessor {
    static func processImageWithPath(_ path: String, spriteWidth: CGFloat, spriteHeight: CGFloat) {
        let fileUrl = URL(fileURLWithPath: path)
        print("processing: \(fileUrl.absoluteString)")
        
        let filename = fileUrl.deletingPathExtension().lastPathComponent
        let directoryPath = fileUrl.deletingLastPathComponent()
        
        guard fileUrl.pathExtension == "png" else {
            print("Can only handle png files.")
            return
        }

        if let image = NSImage(contentsOf: fileUrl) {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            var origin = CGPoint(x: 0, y: imageHeight)
            var i = 0, n = 0
            
            while origin.y > 0 {
                let w = ((origin.x + spriteWidth) < imageWidth) ? spriteWidth : (imageWidth - origin.x)
                let h = ((origin.y - spriteHeight) >= 0) ? spriteHeight : (spriteHeight - origin.y)
                
                let spriteImage = NSImage(size: CGSize(width: spriteWidth, height: spriteHeight), flipped: false, drawingHandler: { rect in
                    let fromRect = CGRect(x: origin.x, y: origin.y - h, width: w, height: h)
                    image.draw(in: CGRect(x: 0, y: 0, width: w, height: h), from: fromRect, operation: .sourceOver, fraction: 1.0)
                    return true
                })
                
                let filename = "\(filename)_\(i).png"
                let pathUrl = directoryPath.appendingPathComponent(filename)
                if !spriteImage.savePNG(fileUrl: pathUrl) {
                    print("failed to save image at: \(pathUrl)")
                }

                i += 1
                origin.x += w
                
                if origin.x == imageWidth {
                    origin.y -= h
                    origin.x = 0
                    n += 1
                }
            }
            
        }
    }
}

extension NSImage {
    var imagePNGRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .PNG, properties: [:])!
    }
    
    func savePNG(fileUrl: URL) -> Bool {
        do {
            try imagePNGRepresentation.write(to: fileUrl, options: .atomic)
        } catch let error {
            print(error)
            return false
        }
        
        return true
    }
}
