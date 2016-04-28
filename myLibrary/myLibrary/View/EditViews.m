//
//  EditViews.m
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import "EditViews.h"

@implementation ImageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.imageView = [UIImageView new];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.imageView];
    
    self.prefixLabel = [UILabel new];
    self.prefixLabel.text = @"图片：";
    self.prefixLabel.font = [UIFont systemFontOfSize:14.0f];
    self.prefixLabel.textColor = [UIColor grayColor];
    self.prefixLabel.backgroundColor = [UIColor clearColor];
    self.prefixLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.prefixLabel];
    
    self.modifyBtn = [UIButton new];
    [self.modifyBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.modifyBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.modifyBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.modifyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.modifyBtn];
    
    [self configConstraints];
}

- (void)bindImage:(NSData *)imageData
{
    if (!imageData) {
        self.imageView.image = [UIImage imageNamed:@"noBook"];
        [self.modifyBtn setTitle:@"添加" forState:UIControlStateNormal];
    }
    else {
        self.imageView.image = [UIImage imageWithData:imageData];
        [self.modifyBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (void)configConstraints
{
    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];
    imageVerticalConstraint.active = YES;
    
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:84.0];
    imageWidthConstraint.active = YES;
    
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:123.0];
    imageHeightConstraint.active = YES;
    
    NSLayoutConstraint *imageHorizonConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    imageHorizonConstraint.active = YES;

    NSLayoutConstraint *prefixLeftConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10.0f];
    prefixLeftConstraint.active = YES;
    
    NSLayoutConstraint *prefixRightConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-5.0f];
    prefixRightConstraint.active = YES;
    
    NSLayoutConstraint *prefixHorizonConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];
    prefixHorizonConstraint.active = YES;
 
    NSLayoutConstraint *btnRightConstraint = [NSLayoutConstraint constraintWithItem:self.modifyBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10.0f];
    btnRightConstraint.active = YES;
    
    NSLayoutConstraint *btnHorizonConstraint = [NSLayoutConstraint constraintWithItem:self.modifyBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];
    btnHorizonConstraint.active = YES;
}

@end

@implementation InputView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.prefixLabel = [UILabel new];
    self.prefixLabel.font = [UIFont systemFontOfSize:14.0f];
    self.prefixLabel.textColor = [UIColor grayColor];
    self.prefixLabel.backgroundColor = [UIColor clearColor];
    self.prefixLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.prefixLabel];
    
    self.content = [UITextField new];
    self.content.layer.borderWidth = 1.0f;
    self.content.layer.borderColor = [UIColor grayColor].CGColor;
    self.content.layer.cornerRadius = 4.0f;
    self.content.font = [UIFont systemFontOfSize:14.0f];
    self.content.backgroundColor = [UIColor clearColor];
    self.content.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.content];
    
    [self configConstraints];
}

- (void)bindPrefix:(NSString *)prefix content:(NSString *)content
{
    self.prefixLabel.text = prefix;
    self.content.text = content;
}

- (void)configConstraints
{
    NSLayoutConstraint *prefixLeftConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10.0f];
    prefixLeftConstraint.active = YES;
    
    NSLayoutConstraint *prefixTopConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    prefixTopConstraint.active = YES;
    
    NSLayoutConstraint *prefixBottomConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f];
    prefixBottomConstraint.active = YES;
    
    NSLayoutConstraint *prefixWidthConstraint = [NSLayoutConstraint constraintWithItem:self.prefixLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0f];
    prefixWidthConstraint.active = YES;
    
    NSLayoutConstraint *contentLeftConstraint = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.prefixLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10.0f];
    contentLeftConstraint.active = YES;
    
    NSLayoutConstraint *contentTopConstraint = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    contentTopConstraint.active = YES;
    
    NSLayoutConstraint *contentBottomConstraint = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f];
    contentBottomConstraint.active = YES;
    
    NSLayoutConstraint *contentRightConstraint = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10.0f];
    contentRightConstraint.active = YES;
}
@end

@implementation EditViews
@end
