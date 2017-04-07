//
//  EMFontChangeView.h
//  Pods
//
//  Created by ryan on 15/12/2016.
//
//

#import <UIKit/UIKit.h>
#import <EMSpeed/UIKitCollections.h>

@interface EMFontChangeView : MSArtPopupContentView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, readwrite) IBOutlet UILabel *fontChangeTitleLabel;

@end
