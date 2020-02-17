//
//  UIScrollView+InteractiveHeader.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveHeaderImageView : UIImageView

@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) CGFloat revealProgress;
@property (nonatomic, assign, readonly) CGFloat extendedRevealProgress;

@property (nonatomic, assign) CGFloat labelOffset;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, assign) BOOL useAlphaFade;
@property (nonatomic, assign) BOOL useFontScaling;

@end

@interface UIScrollView (InteractiveHeader)

@property (nonatomic, strong) InteractiveHeaderImageView *interactiveHeader;

- (void)addHeaderWithImage:(UIImage *)image height:(CGFloat)height;
- (void)removeHeaderView;

@end

