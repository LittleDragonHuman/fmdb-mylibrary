//
//  Book.h
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, assign) NSInteger bookId;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, copy) NSString *author;

@end
