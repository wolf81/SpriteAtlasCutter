//
//  main.swift
//  SpriteAtlasCutter
//
//  Created by Wolfgang Schreurs on 14/01/2017.
//  Copyright © 2017 Wolftrail. All rights reserved.
//

import Foundation
import CommandLineKit

let cli = CommandLine()

let filePath = StringOption(shortFlag: "f", longFlag: "file", required: true,
                            helpMessage: "Path to the input file.")
let width = IntOption(shortFlag: "w", longFlag: "width", required: true,
                          helpMessage: "The width of a single sprite.")
let height = IntOption(shortFlag: "h", longFlag: "height", required: true,
                      helpMessage: "The height of a single sprite.")
let verbosity = BoolOption(shortFlag: "v", longFlag: "verbose",
                              helpMessage: "Print verbose messages.")

cli.addOptions(filePath, width, height, verbosity)

do {
    try cli.parse()
    ImageProcessor.processImageWithPath(filePath.value!, spriteWidth: CGFloat(width.value!), spriteHeight: CGFloat(height.value!))
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}


