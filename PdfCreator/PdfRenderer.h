//
//  PdfRenderer.h
//  CreatePdf
//
//  Created by Kenan Karakecili on 21/11/15.
//  Copyright © 2015 Kenan Karakecili. All rights reserved.
//

@import UIKit;
@import CoreGraphics;

@interface PdfRenderer : NSObject

+ (NSData *)generatePdfFromArray:(NSArray *)contentArray;

@end
