//
//  RSPrivateViewController.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSPrivateViewController.h"
#import "RSCreatCodeViewController.h"

#import "RSPrivateTableViewCell.h"
#import "RSPrivateOtherCell.h"

#import "UIImage+RSExts.h"

#import "RSMePrivateModel.h"

@interface RSPrivateViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, copy) NSArray *demoArray;

@end

@implementation RSPrivateViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self setupMainViews];
}

- (void)setupMainViews {
    [self.tableView registerNib:[UINib nibWithNibName:[RSPrivateOtherCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSPrivateOtherCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSPrivateTableViewCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSPrivateTableViewCell cellID]];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableview dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        RSPrivateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSPrivateTableViewCell cellID] forIndexPath:indexPath];
        cell.logoImgName = @"https://avatars1.githubusercontent.com/u/13641317?s=460&v=4";
        return cell;
    }
    
    RSPrivateOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSPrivateOtherCell cellID] forIndexPath:indexPath];
    RSMePrivateModel *model = [[RSMePrivateModel alloc] init];
    if (indexPath.section == 0) {
        model = self.demoArray[indexPath.row-1];
    }
    if (indexPath.section == 1) {
        model = self.demoArray[indexPath.row+4];
    }
    
    cell.leftLabel.text = model.leftText;
    cell.rightLabel.text = model.rightText;
    cell.rightImageView.image = [UIImage imageName:model.rightImageName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [RSPrivateTableViewCell rowHeight];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        return 100;
    }
    
    return [RSPrivateOtherCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
        sheet.backgroundColor = [UIColor redColor];
        [sheet showInView:self.view];
    }
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        RSCreatCodeViewController *codeVC = [[RSCreatCodeViewController alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    }
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        UIImagePickerController *photoVC = [[UIImagePickerController alloc] init];
        photoVC.delegate = self;
        photoVC.allowsEditing = YES;
        [self presentViewController:photoVC animated:YES completion:nil];
        return;
    }
    
    if (buttonIndex == 0) {
        UIImagePickerController *cameraVC = [[UIImagePickerController alloc] init];
        cameraVC.delegate = self;
        cameraVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:cameraVC animated:YES completion:nil];
    }
}

#pragma mark - ImagePiker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *testImage = info[UIImagePickerControllerOriginalImage];
    
    if (picker.allowsEditing) {
        testImage = info[UIImagePickerControllerEditedImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter getter

- (NSArray *)demoArray {
    if (!_demoArray) {
        _demoArray = [RSMePrivateModel demoData];
    }
    return _demoArray;
}

@end
