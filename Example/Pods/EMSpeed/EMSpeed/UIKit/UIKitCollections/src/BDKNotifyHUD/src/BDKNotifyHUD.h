#import <UIKit/UIKit.h>


#define kBDKNotifyHUDDefaultWidth 150.0f
#define kBDKNotifyHUDDefaultHeight 100.0f

NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
@interface BDKNotifyHUD : UIView

@property (nonatomic) CGFloat destinationOpacity;
@property (nonatomic) CGFloat currentOpacity;
@property (nonatomic) UIView *iconView;
@property (nonatomic) CGFloat roundness;
@property (nonatomic) BOOL bordered;
@property (nonatomic) BOOL isAnimating;

@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) NSString *text;

+ (instancetype)notifyHUDWithView:(UIView *)view text:(NSString *)text;
+ (instancetype)notifyHUDWithImage:(UIImage *)image text:(NSString *)text;

- (instancetype)initWithView:(UIView *)view text:(NSString *)text;
- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text;

- (void)setImage:(UIImage *)image;
- (void)presentWithDuration:(CGFloat)duration speed:(CGFloat)speed inView:(UIView *)view completion:(void (^)(void))completion;

+ (void)showNotifHUDWithImage:(UIImage *)image
                         text:(NSString *)text
                       inView:(UIView *)view
                       center:(CGPoint)center;
+ (void)showNotifHUDWithText:(NSString *)text;
+ (void)showNotifHUDWithTextBottom:(NSString *)text;
+ (void)showNotifHUDWithText:(NSString *)text image:(UIImage *)image;


@end

