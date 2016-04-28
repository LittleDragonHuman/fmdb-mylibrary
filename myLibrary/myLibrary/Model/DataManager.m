//
//  DataManager.m
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import "DataManager.h"

#define CREATE_TABLE @"create table if not exists books(b_id integer primary key autoincrement, b_img blob, b_name text, b_author text);"
#define QUERY_TABLE @"select * from books;"
#define INSERT_TABLE @"insert into books(b_img, b_name, b_author) values(?,?,?);"
#define UPDATE_TABLE @"update books set b_img = ?, b_name = ?, b_author = ? where b_id = ?;"
#define DELETE_TABLE @"delete from books where b_id = ?;"

@implementation DataManager

+ (DataManager *)sharedInstance
{
    static DataManager *_dm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dm = [[DataManager alloc] init];
    });
    return _dm;
}

- (void)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = paths[0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"myLibrary.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        self.db = db;
        self.dbStatus = YES;
        self.tableStatus = [db executeUpdate:CREATE_TABLE];
    }
    else {
        self.db = nil;
        self.dbStatus = NO;
        self.tableStatus = NO;
    }
    NSLog(@"DB Path = %@", dbPath);
    NSLog(@"dbStatus = %@, tableStatus = %@", @(self.dbStatus), @(self.tableStatus));
}

- (NSMutableArray *)allBooks
{
    NSMutableArray *books = [NSMutableArray array];
    if (self.dbStatus && self.tableStatus) {
        FMResultSet *result = [self.db executeQuery:QUERY_TABLE];
        while ([result next]) {
            Book *book = [[Book alloc] init];
            book.bookId = [result intForColumn:@"b_id"];
            book.imageData = [result dataForColumn:@"b_img"];
            book.bookName = [result stringForColumn:@"b_name"];
            book.author = [result stringForColumn:@"b_author"];
            [books addObject:book];
        }
    }
    return books;
}

- (BOOL)insertNewBook:(Book *)book
{
    [self.db beginTransaction];
    BOOL isBack = NO;
    @try {
        [self.db executeUpdate:INSERT_TABLE, book.imageData, book.bookName, book.author];
    }
    @catch (NSException *exception) {
        isBack = YES;
        [self.db rollback];
    }
    @finally {
        if (!isBack) {
            [self.db commit];
            return YES;
        }
    }
    return NO;
}

- (BOOL)updateBook:(Book *)book
{
    [self.db beginTransaction];
    BOOL isBack = NO;
    @try {
        [self.db executeUpdate:UPDATE_TABLE, book.imageData, book.bookName, book.author, @(book.bookId)];
    }
    @catch (NSException *exception) {
        isBack = YES;
        [self.db rollback];
    }
    @finally {
        if (!isBack) {
            [self.db commit];
            return YES;
        }
    }
    return NO;
}

- (BOOL)deleteBook:(NSInteger)bookId
{
    [self.db beginTransaction];
    BOOL isBack = NO;
    @try {
        [self.db executeUpdate:DELETE_TABLE, @(bookId)];
    }
    @catch (NSException *exception) {
        isBack = YES;
        [self.db rollback];
    }
    @finally {
        if (!isBack) {
            [self.db commit];
            return YES;
        }
    }
    return NO;
}

@end
