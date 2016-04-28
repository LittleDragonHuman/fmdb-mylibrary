//
//  ListCell.m
//  myLibrary
//
//  Created by fly on 16/4/28.
//
//

#import "ListCell.h"

@implementation ListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.bookImageView = [UIImageView new];
    self.bookImageView.backgroundColor = [UIColor redColor];
    self.bookImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bookImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bookImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.bookImageView];
    
    self.bookNameLabel = [UILabel new];
    self.bookNameLabel.backgroundColor = [UIColor clearColor];
    self.bookNameLabel.font = [UIFont systemFontOfSize:20];
    self.bookNameLabel.textColor = [UIColor blackColor];
    self.bookNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.bookNameLabel];

    self.authorLabel = [UILabel new];
    self.authorLabel.backgroundColor = [UIColor clearColor];
    self.authorLabel.font = [UIFont systemFontOfSize:16];
    self.authorLabel.textColor = [UIColor grayColor];
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.authorLabel];

    [self configContraints];
}

- (void)bindBook:(Book *)book
{
    if (!book.imageData) {
        self.bookImageView.image = [UIImage imageNamed:@"noBook"];
    }
    else {
        self.bookImageView.image = [UIImage imageWithData:book.imageData];
    }
    self.bookNameLabel.text = book.bookName;
    self.authorLabel.text = book.author;
}

- (void)configContraints
{
    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];
    imageVerticalConstraint.active = YES;
    
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:56.0f];
    imageWidthConstraint.active = YES;
    
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:82.0f];
    imageHeightConstraint.active = YES;
    
    NSLayoutConstraint *imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0f];
    imageLeftConstraint.active = YES;
    
    NSLayoutConstraint *nameLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bookImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.0f];
    nameLeftConstraint.active = YES;

    NSLayoutConstraint *nameTopConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bookImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    nameTopConstraint.active = YES;

    NSLayoutConstraint *nameRightConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    nameRightConstraint.active = YES;

    NSLayoutConstraint *authorLeftConstraint = [NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bookNameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    authorLeftConstraint.active = YES;
    
    NSLayoutConstraint *authorTopConstraint = [NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bookNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0f];
    authorTopConstraint.active = YES;
    
    NSLayoutConstraint *authorRightConstraint = [NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bookNameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    authorRightConstraint.active = YES;
}
@end
