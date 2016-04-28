//
//  ListCell.h
//  myLibrary
//
//  Created by fly on 16/4/28.
//
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface ListCell : UITableViewCell
@property (nonatomic, strong) UIImageView *bookImageView;
@property (nonatomic, strong) UILabel *bookNameLabel;
@property (nonatomic, strong) UILabel *authorLabel;
- (void)bindBook:(Book *)book;
@end
