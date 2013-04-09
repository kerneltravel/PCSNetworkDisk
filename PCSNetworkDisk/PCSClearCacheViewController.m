//
//  PCSClearCacheViewController.m
//  PCSNetworkDisk
//
//  Created by wangzz on 13-4-8.
//  Copyright (c) 2013年 hisunsray. All rights reserved.
//

#import "PCSClearCacheViewController.h"
#import "UIAlertView-Blocks/UIAlertView+Blocks.h"

@interface PCSClearCacheViewController ()
@property(nonatomic,retain) IBOutlet    UITableView *mTableView;

@end

@implementation PCSClearCacheViewController
@synthesize mTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return @"离线可用文件是保存到本地的文件，可以在离线环境下查看。";
    } else if (section == 1) {
        return @"其它缓存是指文件上传，或者在线查看文件过程中产生的本地文件。";
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"MoreViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellid];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *offlinePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:PCS_FOLDER_OFFLINE_CACHE];
            NSString    *unitString = [[PCSDBOperater shareInstance] getFormatSizeString:
                                       [[PCSDBOperater shareInstance] fileSizeAtPath:offlinePath]];
            cell.textLabel.text = [NSString stringWithFormat:@"离线可用(已使用%@)",unitString];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"                 清空离线可用文件";
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *uploadPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:PCS_FOLDER_UPLOAD_CACHE];
            NSString    *unitString = [[PCSDBOperater shareInstance] getFormatSizeString:
                                       [[PCSDBOperater shareInstance] fileSizeAtPath:uploadPath]];
            cell.textLabel.text = [NSString stringWithFormat:@"其它缓存(已使用%@)",unitString];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"              清空其他文件本地缓存";
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        void (^clearAction)();
        NSString    *message = nil;
        if (indexPath.section == 0) {
            message = @"确定清空离线可用文件？";
            clearAction = ^{
                NSString *offlinePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:PCS_FOLDER_OFFLINE_CACHE];
                BOOL    result = NO;
                result = [[PCSDBOperater shareInstance] clearDataAtPath:offlinePath];
                if (result) {
                    [self.mTableView reloadData];
                }
            };
        } else if (indexPath.section == 1) {
            message = @"确定清空其它缓存文件？";
            clearAction = ^{
                NSString *uploadPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:PCS_FOLDER_UPLOAD_CACHE];
                BOOL    result = NO;
                result = [[PCSDBOperater shareInstance] clearDataAtPath:uploadPath];
                if (result) {
                    [self.mTableView reloadData];
                }
            };
        }
        RIButtonItem *cancelItem = [RIButtonItem item];
        cancelItem.label = @"取消";

        RIButtonItem *doItem = [RIButtonItem item];
        doItem.label = @"清空";
        doItem.action = clearAction;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:message
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:doItem, nil];
        [alert show];
        PCS_FUNC_SAFELY_RELEASE(alert);
    }
}

@end