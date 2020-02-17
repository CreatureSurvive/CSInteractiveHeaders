//
//  UIScrollView+InteractiveHeader.m
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 1/21/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "UIScrollView+InteractiveHeader.h"
#import <objc/runtime.h>

static NSString *kInteractiveHeaderKey = @"interactiveHeader";

@implementation InteractiveHeaderImageView {
    UIStackView *_labelStack;
    NSLayoutConstraint *_labelCenter;
    CGAffineTransform _stackTransform;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        _labelStack = [UIStackView new];
        _labelStack.translatesAutoresizingMaskIntoConstraints = NO;
        _labelStack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _labelStack.axis = UILayoutConstraintAxisVertical;
        _labelStack.alignment = UIStackViewAlignmentLeading;
        _labelStack.distribution = UIStackViewDistributionEqualCentering;
        _labelStack.spacing = 10;
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = [UIColor.lightTextColor colorWithAlphaComponent:1];
        self.titleLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
        [_labelStack addArrangedSubview:self.titleLabel];
        
        self.subtitleLabel = [UILabel new];
        self.subtitleLabel.textColor = UIColor.lightTextColor;
        self.subtitleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        [_labelStack addArrangedSubview:self.subtitleLabel];

        [self addSubview:_labelStack];
        [_labelStack.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:16].active = YES;
        _labelCenter = [_labelStack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:self.labelOffset];
        _labelCenter.active = YES;
    }
    
    return self;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    _scrollView = scrollView;
    
    if (_scrollView) {
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setLabelOffset:(CGFloat)labelOffset {
    _labelOffset = labelOffset;
    _labelCenter.constant = labelOffset;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self setScrollView:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIScrollView *scrollView = self.scrollView;
    CGFloat height = self.defaultHeight;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat additionalHeight = (-offset - height);
    
    // configure insets
    scrollView.contentInset = UIEdgeInsetsMake(height - scrollView.safeAreaInsets.top, 0, scrollView.safeAreaInsets.bottom, 0);
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(-offset > scrollView.safeAreaInsets.top ? -offset - scrollView.safeAreaInsets.top : scrollView.verticalScrollIndicatorInsets.top, scrollView.verticalScrollIndicatorInsets.left, scrollView.verticalScrollIndicatorInsets.bottom, scrollView.verticalScrollIndicatorInsets.right);

    // configure header frame
    self.frame = CGRectMake(0, (additionalHeight > 0 ? offset : -height), scrollView.bounds.size.width, height + (additionalHeight > 0 ? additionalHeight : 0));
    
    // configure reveal progress
    _revealProgress = additionalHeight < 0 ? MIN(1, 1 - (-additionalHeight / (height - scrollView.safeAreaInsets.top))) : 1;
    _extendedRevealProgress = -offset / height;
    
    // alpha fading
    if (_useAlphaFade) {
        for (UIView *subview in self.subviews) {
            [subview setAlpha:_revealProgress];
        }
    }
    
    // font scaling
    if (_useFontScaling && _extendedRevealProgress >= 1 && _extendedRevealProgress <= 1.75) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:28 * _extendedRevealProgress weight:UIFontWeightBold * _extendedRevealProgress]];
        [self.subtitleLabel setFont:[UIFont systemFontOfSize:17 * _extendedRevealProgress weight:UIFontWeightRegular * _extendedRevealProgress]];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // layout only if the header is within view
//        if ([(NSValue *)change[NSKeyValueChangeNewKey] CGPointValue].y < 0) {
            [self setNeedsLayout];
//        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

@implementation UIScrollView (InteractiveHeader)

- (InteractiveHeaderImageView *)interactiveHeader {
    return objc_getAssociatedObject(self, &kInteractiveHeaderKey);
}

- (void)setInteractiveHeader:(InteractiveHeaderImageView *)interactiveHeader {
    objc_setAssociatedObject(self, &kInteractiveHeaderKey, interactiveHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addHeaderWithImage:(UIImage *)image height:(CGFloat)height {
    if (self.interactiveHeader) {
        [self.interactiveHeader removeFromSuperview];
    }
    
    InteractiveHeaderImageView *header = [[InteractiveHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
    [header setBackgroundColor:UIColor.clearColor];
    [header setImage:image];
    [header setDefaultHeight:height];
    [header setScrollView:self];

    [self addSubview:header];
    [self sendSubviewToBack:header];

    [self setInteractiveHeader:header];
    [self setContentInset:UIEdgeInsetsMake(height - self.safeAreaInsets.top, self.safeAreaInsets.left, self.safeAreaInsets.right, self.safeAreaInsets.bottom)];
}

- (void)removeHeaderView {
    if (self.interactiveHeader) {
        [self.interactiveHeader removeFromSuperview];
        [self setInteractiveHeader:nil];
    }
}

@end
