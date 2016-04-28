//
//  EditViews.h
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView
@property (nonatomic, strong) UILabel *prefixLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *modifyBtn;
- (void)bindImage:(NSData *)imageData;
@end

@interface InputView : UIView
@property (nonatomic, strong) UILabel *prefixLabel;
@property (nonatomic, strong) UITextField *content;
- (void)bindPrefix:(NSString *)prefix content:(NSString *)content;
@end

@interface EditViews : UIView
@end
