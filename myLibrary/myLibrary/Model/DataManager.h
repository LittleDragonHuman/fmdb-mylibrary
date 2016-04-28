//
//  DataManager.h
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "Book.h"

@interface DataManager : NSObject

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, assign) BOOL dbStatus;
@property (nonatomic, assign) BOOL tableStatus;

+ (DataManager *)sharedInstance;

- (void)openDB;

- (NSMutableArray *)allBooks;

- (BOOL)insertNewBook:(Book *)book;

- (BOOL)updateBook:(Book *)book;

- (BOOL)deleteBook:(NSInteger)bookId;

@end
