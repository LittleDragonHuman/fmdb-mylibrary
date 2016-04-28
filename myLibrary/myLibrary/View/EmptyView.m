//
//  EmptyView.m
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import "EmptyView.h"

@implementation EmptyView
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
    CGFloat width = self.frame.size.width - 2 * 10;
    UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, width, 20.0f)];
    emptyLabel.text = @"您暂时还没有任何图书噢~";
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.textColor = [UIColor grayColor];
    emptyLabel.font = [UIFont systemFontOfSize:16.0];
    emptyLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:emptyLabel];
}
@end
