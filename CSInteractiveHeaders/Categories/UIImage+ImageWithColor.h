//
//  UIImage+ImageWithColor.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageWithColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
