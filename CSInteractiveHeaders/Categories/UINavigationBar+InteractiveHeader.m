//
//  UINavigationBar+InteractiveHeader.m
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "UINavigationBar+InteractiveHeader.h"
#import "UIScrollView+InteractiveHeader.h"
#import "UIImage+ImageWithColor.h"
#import "UIColor+Interpolation.h"
#import <objc/runtime.h>

static NSString *kScrollColorKey = @"scrollColor";
static NSString *kScrollTintColorKey = @"scrollTintColor";
static NSString *kScrollViewKey = @"scrollView";

@implementation UINavigationBar (InteractiveHeader)

- (UIColor *)scrollColor {
    return objc_getAssociatedObject(self, &kScrollColorKey);
}

- (void)setScrollColor:(UIColor *)scrollColor {
    objc_setAssociatedObject(self, &kScrollColorKey, scrollColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)scrollTintColor {
    return objc_getAssociatedObject(self, &kScrollTintColorKey);
}

- (void)setScrollTintColor:(UIColor *)scrollColor {
    objc_setAssociatedObject(self, &kScrollTintColorKey, scrollColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)scrollView {
    return objc_getAssociatedObject(self, &kScrollViewKey);
}

- (void)setScrollView:(UIScrollView *)scrollView {
    objc_setAssociatedObject(self, &kScrollViewKey, scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTranslucent:YES];
    [self setShadowImage:[UIImage new]];
    [self setBarStyle:UIBarStyleDefault];
    [self setTintColor:UIColor.whiteColor];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}];
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)updateAlpha:(CGFloat)alpha {
    UIColor *color = [self.scrollColor ? : UIColor.whiteColor colorWithAlphaComponent:alpha];
    
    [self setTintColor:[UIColor.whiteColor lerpToColor:self.scrollTintColor withFraction:alpha]];
    [self setBackgroundImage:alpha < 1 && alpha > 0 ? [UIImage imageWithColor:color] : alpha >= 1 ? nil : [UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)resetAppearance {
    if (self.scrollView) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [self setScrollView:nil];
    }
    
    [self setTintColor:nil];
    [self setShadowImage:nil];
    [self setBarTintColor:nil];
    [self setTitleTextAttributes:nil];
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
//        if ([(NSValue *)change[NSKeyValueChangeNewKey] CGPointValue].y < 0) {
            [self updateAlpha:0.9 - self.scrollView.interactiveHeader.revealProgress];
//        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
