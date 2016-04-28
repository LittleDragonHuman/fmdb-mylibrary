//
//  EditViewController.m
//  myLibrary
//
//  Created by fly on 16/4/26.
//
//

#import "EditViewController.h"
#import "DataManager.h"
#import "EditViews.h"

@interface EditViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) ImageView *bookImageView;
@property (nonatomic, strong) InputView *bookNameView;
@property (nonatomic, strong) InputView *bookAuthorView;
@property (nonatomic, strong) Book *book;

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = (self.editType ? @"编辑图书" : @"新建图书");
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveBook)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setUpImageView];
    [self setUpNameView];
    [self setUpAuthorView];
    
    self.book = [[Book alloc] init];
    if (self.oldBook) {
        self.book.bookId = self.oldBook.bookId;
        self.book.imageData = self.oldBook.imageData;
        self.book.bookName = self.oldBook.bookName;
        self.book.author = self.oldBook.author;
    }
    [self bindBook];
}

- (void)bindBook
{
    [self.bookImageView bindImage:self.book.imageData];
    [self.bookNameView bindPrefix:@"书名：" content:self.book.bookName];
    [self.bookAuthorView bindPrefix:@"作者：" content:self.book.author];
}

- (void)saveBook
{
    self.book.bookName = self.bookNameView.content.text;
    self.book.author = self.bookAuthorView.content.text;
    
    if (!self.book.bookName || [self.book.bookName isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入书名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self.bookNameView.content becomeFirstResponder];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (self.editType == 0) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            BOOL status = [[DataManager sharedInstance] insertNewBook:self.book];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *res = status ? @"保存成功" : @"保存失败";
                [self showAlertController:res status:status];
            });
        });
    }
    else if (self.editType == 1) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            BOOL status = [[DataManager sharedInstance] updateBook:self.book];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *res = status ? @"更新成功" : @"更新失败";
                [self showAlertController:res status:status];
            });
        });
    }
    else {}
}

- (void)showAlertController:(NSString *)tipStr status:(BOOL)status
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:tipStr
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if (status && self.block) {
            self.block();
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)editImage
{
    if (self.book.imageData) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"图片操作类型" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *edit = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImage];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            self.book.imageData = nil;
            [self bindBook];
        }];
        
        [alert addAction:edit];
        [alert addAction:cancel];
        [alert addAction:delete];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self pickImage];
    }
}

- (void)pickImage
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
    pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickImage.delegate = self;
    [self presentViewController:pickImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (!image) {
        return;
    }
    self.book.imageData = UIImagePNGRepresentation(image);
    [self bindBook];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.bookNameView.content) {
        self.book.bookName = textField.text;
    }
    else if (textField == self.bookAuthorView.content) {
        self.book.author = textField.text;
    }
    else {}
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField == self.bookNameView.content) {
        self.book.bookName = @"";
    }
    else if (textField == self.bookAuthorView.content) {
        self.book.author = @"";
    }
    else {}
    return YES;
}

- (void)setUpImageView
{
    self.bookImageView = [ImageView new];
    self.bookImageView.backgroundColor = [UIColor clearColor];
    self.bookImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bookImageView];
    
    [self.bookImageView.modifyBtn addTarget:self action:@selector(editImage) forControlEvents:UIControlEventTouchUpInside];

    NSLayoutConstraint *imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    imageLeftConstraint.active = YES;
    
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    imageWidthConstraint.active = YES;
    
    NSLayoutConstraint *imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80.0f];
    imageTopConstraint.active = YES;
    
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bookImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0];
    imageHeightConstraint.active = YES;
}

- (void)setUpNameView
{
    self.bookNameView = [InputView new];
    self.bookNameView.backgroundColor = [UIColor clearColor];
    self.bookNameView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bookNameView.content.delegate = self;
    [self.view addSubview:self.bookNameView];
    
    NSLayoutConstraint *nameLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    nameLeftConstraint.active = YES;
    
    NSLayoutConstraint *nameWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    nameWidthConstraint.active = YES;
    
    NSLayoutConstraint *nameTopConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bookImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30.0f];
    nameTopConstraint.active = YES;
    
    NSLayoutConstraint *nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bookNameView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0f];
    nameHeightConstraint.active = YES;
}

- (void)setUpAuthorView
{
    self.bookAuthorView = [InputView new];
    self.bookAuthorView.backgroundColor = [UIColor clearColor];
    self.bookAuthorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bookAuthorView.content.delegate = self;
    [self.view addSubview:self.bookAuthorView];
    
    NSLayoutConstraint *authorLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bookAuthorView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    authorLeftConstraint.active = YES;
    
    NSLayoutConstraint *authorWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bookAuthorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    authorWidthConstraint.active = YES;
    
    NSLayoutConstraint *authorTopConstraint = [NSLayoutConstraint constraintWithItem:self.bookAuthorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bookNameView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30.0f];
    authorTopConstraint.active = YES;
    
    NSLayoutConstraint *authorHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bookAuthorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0f];
    authorHeightConstraint.active = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
