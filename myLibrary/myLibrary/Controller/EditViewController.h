//
//  EditViewController.h
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import <UIKit/UIKit.h>
#import "Book.h"

typedef void(^editBookBlock)();

@interface EditViewController : UIViewController

@property (nonatomic, assign) NSInteger editType; //0-添加 1-修改
@property (nonatomic, strong) Book *oldBook; //修改状态下，book来自列表
@property (nonatomic, copy) editBookBlock block;

@end
