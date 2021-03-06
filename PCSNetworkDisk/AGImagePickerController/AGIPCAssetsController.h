//
//  AGIPCAssetsController.h
//  AGImagePickerController
//
//  Created by Artur Grigor on 17.02.2012.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//  
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//  

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "AGIPCGridItem.h"
#import "HSDirectoryDelegate.h"

@interface AGIPCAssetsController : UIViewController<UITableViewDataSource, UITableViewDelegate, AGIPCGridItemDelegate,HSDirectoryDelegate>
{
    UITableView *tableView;
    ALAssetsGroup *assetsGroup;
    
    NSMutableArray *assets;
    BOOL    selectAllAssets;
}

@property (retain) ALAssetsGroup *assetsGroup;
@property (retain) IBOutlet UITableView *tableView;

@property (readonly) NSArray *selectedAssets;
@property (assign) PCSImagePickerType   imagePickerType;

- (id)initWithAssetsGroup:(ALAssetsGroup *)theAssetsGroup type:(PCSImagePickerType)type;

@end
