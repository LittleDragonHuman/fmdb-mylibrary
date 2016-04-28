//
//  RootViewController.m
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import "RootViewController.h"
#import "EditViewController.h"
#import "ListCell.h"
#import "EmptyView.h"
#import "DataManager.h"
#import "Book.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EmptyView *emptyView;
@property (nonatomic, strong) NSMutableArray *allBooks;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的图书馆";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewBook)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.frame.size.width, self.view.frame.size.height -64.0f)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.emptyView = [[EmptyView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f)];
    [self.view addSubview:self.emptyView];
    
    self.allBooks = [NSMutableArray array];
    
    [self fetchBooks];
}

- (void)fetchBooks
{
    [self.allBooks removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *books = [[DataManager sharedInstance] allBooks];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.allBooks addObjectsFromArray:books];
            [self updateViews];
        });
    });
}

- (void)updateViews
{
    if (self.allBooks.count > 0) {
        self.emptyView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
    else {
        self.emptyView.hidden = NO;
        self.tableView.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allBooks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = self.allBooks[indexPath.row];
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    if (!cell) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bookCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindBook:book];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Book *book = self.allBooks[indexPath.row];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[DataManager sharedInstance] deleteBook:book.bookId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.allBooks removeObjectAtIndex:indexPath.row];
                [self updateViews];
            });
        });
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = self.allBooks[indexPath.row];
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.editType = 1;
    editVC.oldBook = book;
    editVC.block = ^() {
        [self fetchBooks];
    };
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)addNewBook
{
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.editType = 0;
    editVC.block = ^() {
        [self fetchBooks];
    };
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
