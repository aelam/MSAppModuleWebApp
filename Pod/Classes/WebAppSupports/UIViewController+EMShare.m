////
////  UIViewController+EMShare.m
////  EMStock
////
////  Created by jenkins on 15/6/11.
////  Copyright (c) 2015年 flora. All rights reserved.
////
//
//#import "UIViewController+EMShare.h"
//#import "EMSocialSDK+URLBind.h"
//#import <BDKNotifyHUD.h>
//#import <EMSpeed/MSUIKitCore.h>
//
//@implementation UIViewController (EMShare)
//
//@dynamic isShareItemEnabled;
//@dynamic shareEntity;
//
//- (UIBarButtonItem *)shareItem {
//    UIImage *image = [UIImage navBarImageWithIcon:@"em-icon-share-alt" size:CGSizeMake(20, 20) ];
//    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareButton setImage:image forState:UIControlStateNormal];
//    shareButton.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
//    shareButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
//    CGSize itemSize = CGSizeMake(28, MSNavigationBarHeight()-8);
//    shareButton.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
//    [shareButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
//    self.navigationItem.rightBarButtonItem = shareItem;
//
//    return shareItem;
//}
//
//- (void)doShare {
//    EMShareEntity *entity = [self shareEntity];
//    if (entity) {
//        [self share:entity];
//    }
//}
//
//- (void)share:(EMShareEntity *)shareEntity {
//    [[EMSocialSDK sharedSDK] shareEntity:shareEntity rootViewController:self completionHandler:^(NSString *activityType, BOOL completed, NSDictionary *returnedInfo, NSError *activityError) {
//        NSString *message = nil;
//        if ([activityType isEqualToString:UIActivityTypePostToSinaWeibo]) {
//            NSLog(@"%@", returnedInfo[EMActivityWeiboStatusMessageKey]);
//            message = returnedInfo[EMActivityWeiboStatusMessageKey];
//        } else if([activityType isEqualToString:UIActivityTypePostToWeChatSession] ||
//                  [activityType isEqualToString:UIActivityTypePostToWeChatTimeline]
//                  ) {
//            NSLog(@"%@", returnedInfo[EMActivityWeChatStatusMessageKey]);
//            message = returnedInfo[EMActivityWeChatStatusMessageKey];
//        }
//        
//        if (message.length > 0) {
//            [BDKNotifyHUD showNotifHUDWithText:message];
//        }
//    }];
//}
//
//
//@end
