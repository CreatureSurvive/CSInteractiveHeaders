//
//  UIColor+Interpolation.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Interpolation)

- (UIColor *)lerpToColor:(UIColor *)color withFraction:(CGFloat)fraction;

@end
