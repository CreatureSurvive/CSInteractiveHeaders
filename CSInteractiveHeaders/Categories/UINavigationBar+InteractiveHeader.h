//
//  UINavigationBar+InteractiveHeader.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (InteractiveHeaders)

@property (nonatomic, strong) UIColor *scrollColor;
@property (nonatomic, strong) UIColor *scrollTintColor;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)resetAppearance;

@end

