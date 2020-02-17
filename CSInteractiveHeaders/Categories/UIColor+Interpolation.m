//
//  UIColor+Interpolation.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "UIColor+Interpolation.h"

@implementation UIColor (Interpolation)


- (UIColor *)lerpToColor:(UIColor *)color withFraction:(CGFloat)fraction {
    fraction = MAX(0, fraction);
    fraction = MIN(1, fraction);
    
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat r = r1 + (r2 - r1) * fraction;
    CGFloat g = g1 + (g2 - g1) * fraction;
    CGFloat b = b1 + (b2 - b1) * fraction;
    CGFloat a = a1 + (a2 - a1) * fraction;

    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
