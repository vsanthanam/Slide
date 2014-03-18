//
//  SGBoardPiece.m
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGBoardPiece.h"

@implementation SGBoardPiece

@synthesize status = _status;

#pragma mark - Property Access Methods

- (void)setStatus:(SGBoardSquare)status {
    
    self->_status = status;
    [self setNeedsDisplay];
    
}

#pragma mark - Overridden Instance Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.status = SGBoardSquareE;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    if (self.status == SGBoardSquare2) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.8 green: 1 blue: 0.867 alpha: 1];
        
        //// Abstracted Attributes
        NSString* textContent = @"2";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Text Drawing
        CGRect textRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [textStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: textStyle};
        
        [textContent drawInRect: textRect withAttributes: textFontAttributes];
        

    } else if (self.status == SGBoardSquare4) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.571 green: 1 blue: 0.714 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"4";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];

        
    } else if (self.status == SGBoardSquare8) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.343 green: 1 blue: 0.562 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"8";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];


    } else if (self.status == SGBoardSquare16) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.114 green: 1 blue: 0.41 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"16";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
    
    } else if (self.status == SGBoardSquare32) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0.886 blue: 0.295 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"32";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];

        
    } else if (self.status == SGBoardSquare64) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0.657 blue: 0.219 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"64";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 0, 60, 64);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 50], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
    
    } else if (self.status == SGBoardSquare128) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.571 green: 0.571 blue: 1 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"128";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 13, 60, 38);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 34], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];

        
    } else if (self.status == SGBoardSquare256) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.343 green: 0.343 blue: 1 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"256";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 13, 60, 38);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 34], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
        
    } else if (self.status == SGBoardSquare512) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.114 green: 0.114 blue: 1 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"512";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 13, 60, 38);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 34], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
        
    } else if (self.status == SGBoardSquare1024) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0 blue: 0.886 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"1024";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 18, 60, 28);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 23.5], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
        

        
    } else if (self.status == SGBoardSquare2048) {
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0 blue: 0.657 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        //// Abstracted Attributes
        NSString* testContent = @"2048";
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
        
        //// Test Drawing
        CGRect testRect = CGRectMake(2, 18, 60, 28);
        NSMutableParagraphStyle* testStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [testStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* testFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 23.5], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: testStyle};
        
        [testContent drawInRect: testRect withAttributes: testFontAttributes];
    
    } else {
      
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.8 green: 1 blue: 0.867 alpha: 1];
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 64, 64)];
        [color setFill];
        [rectanglePath fill];
        
    }
    
}


@end
