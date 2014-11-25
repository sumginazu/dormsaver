//
//  RSTMALLCell.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTMALLCell.h"

@implementation RSTMALLCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.imagesPlaceHolderWidth = NSIntegerMin;
        [self addObserver:self forKeyPath:@"border" options:NSKeyValueObservingOptionInitial context:NULL];
        [self addObserver:self forKeyPath:@"contentView" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"border"]) {
        self.border.backgroundColor = [UIColor whiteColor];
        
        self.border.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.6] CGColor];
        self.border.layer.borderWidth = 1;
    } else if ([keyPath isEqualToString:@"contentView"]) {
        self.contentView.backgroundColor = kCellBackgroundColor;
    }
}

- (CGFloat)imagesPlaceHolderWidth
{
    if (_imagesPlaceHolderWidth == NSIntegerMin) {
        // Take constraint from autolayout or change 0 to other suitable value
        _imagesPlaceHolderWidth = 0;
        for (NSLayoutConstraint *constraint in self.border.constraints) {
            if ((constraint.firstAttribute == NSLayoutAttributeTrailing
                 || constraint.secondAttribute == NSLayoutAttributeTrailing)
                && constraint.constant > 0) {
                _imagesPlaceHolderWidth = constraint.constant;
                break;
            }
        }
    }
    return _imagesPlaceHolderWidth;
}

@end
