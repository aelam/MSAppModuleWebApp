//
//  EMWebErrorView.h
//  Pods
//
//  Created by ryan on 5/23/16.
//
//

#import <UIKit/UIKit.h>

typedef void(^EMWebErrorViewTapBlock)(void);

@interface EMWebErrorView : UIView

@property (nonatomic, copy) EMWebErrorViewTapBlock tapBlock;
@property (nonatomic, strong) UIImage *errorImage; // [UIImage webAppImageNamed:@"web_icon_logo"] TODO

@end
