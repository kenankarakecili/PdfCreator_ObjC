//
//  PdfRenderer.h
//  CreatePdf
//
//  Created by Kenan Karakecili on 21/11/15.
//  Copyright © 2015 Kenan Karakecili. All rights reserved.
//

#import "PdfRenderer.h"

@implementation PdfRenderer

+ (NSData *)generatePdfFromArray:(NSArray *)contentArray {
    //    NSString *fileName = @"Invoice.pdf";
    //    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(
    //                                        NSDocumentDirectory,
    //                                        NSUserDomainMask,
    //                                        YES);
    //    NSString *path = arrayPaths.firstObject;
    //    NSString *pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    // Create the PDF context using the default page size of 612 x 792.
    //    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    NSMutableData *pdfData = [[NSMutableData alloc] init];
    UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil);
    
    for (NSDictionary *contextDictionary in contentArray) {
        //begin page
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 671, 792), nil);
        UIImage *image = contextDictionary[@"image"];
        [self addImage:image withFrame:CGRectMake(14, 14, 643, 300)];
        [self addText:contextDictionary[@"title"]
            withFrame:CGRectMake(14, 328, 650, 50)
                 font:[UIFont boldSystemFontOfSize:22]
             aligment:NSTextAlignmentLeft];
        [self addText:contextDictionary[@"text"]
            withFrame:CGRectMake(14, 374, 650, 100)
                 font:[UIFont systemFontOfSize:16]
             aligment:NSTextAlignmentLeft];
    }
    UIGraphicsEndPDFContext();
    //    [self performSegueWithIdentifier:@"FavouritesVC_to_FavouritesPdfVC" sender:nil];
    return pdfData;
}

+ (void)addImage:(UIImage *)image withFrame:(CGRect)frame {
    [image drawInRect:frame];
}

+ (void)addText:(NSString*)text withFrame:(CGRect)frame font:(UIFont *)font aligment:(NSTextAlignment)aligment {
    CGSize textSize = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(671, 792)
                           lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textSize.height);
    
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:NSLineBreakByWordWrapping
           alignment:aligment];
}

+ (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, frame.size.height);
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    return frame;
}

@end
