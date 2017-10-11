//
//  NSURL+ParseParam.m
//  MSAppModuleWebApp
//
//  Created by RenChao on 2017/10/11.
//

#import "NSURL+ParseParam.h"

@implementation NSURL (ParseParam)

- (NSDictionary *)parseParam
{
    NSArray *params = [self.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    for (NSString *str in params) {
        NSArray *tempArray = [str componentsSeparatedByString:@"="];
        [tempDic setObject:[tempArray lastObject] forKey:[tempArray firstObject]];
    }
    
    return tempDic;
}

@end
