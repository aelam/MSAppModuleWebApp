#import "NSString+Pinyin.h"
#import "pinyin.h"

@implementation NSString(Pinyin)

+ (void)swap:(NSMutableString*)src replace:(NSMutableString*)rep index:(int)index
{
    NSRange range = NSMakeRange(index, 1);
    NSString* temp = [src substringWithRange:range];
    [src replaceCharactersInRange:range withString:[rep substringWithRange:range]];
    [rep replaceCharactersInRange:range withString:temp];
}

+ (void)perm:(NSMutableString*)dest original:(NSMutableString*)ori replace:(NSMutableString*)rep length:(int)len
{
//    NSLog(@"call perm...\n");
    if (len == [ori length]) { 
        if ([dest rangeOfString:ori options: NSCaseInsensitiveSearch].location == NSNotFound) {
            if ([dest length] == 0) {
                [dest appendFormat:@"%@",ori];
            }
            else {
                [dest appendFormat:@",%@",ori];
            }
        }
    }
    else {
        for (int i = len; i < [ori length]; i++) {
//            if ([ori characterAtIndex:i] != [rep characterAtIndex:i]) {
                [NSString swap:ori replace:rep index:i];
                [NSString perm:dest original:ori replace:rep length:len+1];
                [NSString swap:ori replace:rep index:i];
//            }
        }
    }
}

- (BOOL)compareCharacterAtIndex:(NSUInteger)index withString:(NSString *)string {
    if([self characterAtIndex:index] == [string characterAtIndex:0])
        return YES;
    return NO;
}

- (unichar)dyzAtIndex:(NSUInteger)i
{
    unichar firstLetter = 0;
    //多音字
    if([self compareCharacterAtIndex:i withString:@"行"])
        firstLetter = 'x';
    else if([self compareCharacterAtIndex:i withString:@"藏"])
        firstLetter = 'c';
    else if([self compareCharacterAtIndex:i withString:@"圳"])
        firstLetter = 'c';
    else if([self compareCharacterAtIndex:i withString:@"重"])
        firstLetter = 'c';
    else if([self compareCharacterAtIndex:i withString:@"厦"])
        firstLetter = 'x';
    else if([self compareCharacterAtIndex:i withString:@"调"])
        firstLetter = 't';
    else if([self compareCharacterAtIndex:i withString:@"长"])
        firstLetter = 'c';
    return firstLetter;
}

- (unichar)pinyinFirstLetterAtIndex:(NSUInteger)i 
{
    unichar c = [self characterAtIndex:i];
    if((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9')) {
        return tolower(c);
    }
    else {
        return pinyinFirstLetter([self characterAtIndex:i]);
    }
}

//- (NSString *)pinyinFirstLetterArray 
//{
//    NSMutableString *pinyin = [NSMutableString string];
//    unichar dyz = 0;
//    NSInteger index = -1;
//    for(NSUInteger i = 0; i < self.length; i++) {
//        NSString *firstLetter = [NSString stringWithFormat:@"%c", [self pinyinFirstLetterAtIndex:i]];
//        [pinyin appendString:firstLetter];
//        if (dyz == 0) {
//            dyz = [self dyzAtIndex:i];
//            if (dyz != 0) {
//                index = [pinyin length]>0?[pinyin length]-1:0;
//            }
//        }
//    }
//    if (dyz!=0 && index>=0) {
//        NSString* temp = [pinyin stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:[NSString stringWithFormat:@"%c", dyz]];
//        [pinyin appendFormat:@",%@",temp];
//    }
//    return pinyin;
//}

- (NSString *)ms_pinyinFirstLetterArray 
{
    NSMutableString *result = [NSMutableString string];
    NSMutableString *pinyin = [NSMutableString string];
    NSMutableString *dyz = [NSMutableString string];
    for(NSUInteger i = 0; i < self.length; i++) {
        NSString *firstLetter = [NSString stringWithFormat:@"%c", [self pinyinFirstLetterAtIndex:i]];
        [pinyin appendString:firstLetter];
        
        if ([self dyzAtIndex:i] == 0) {
            [dyz appendString:firstLetter];
        }
        else {
            unichar c_dyz = [self dyzAtIndex:i];
            [dyz appendFormat:@"%c", c_dyz];
        }
    }
    if ([dyz compare:pinyin] != NSOrderedSame) {
        [NSString perm:result original:pinyin replace:dyz length:0];
    }
    else {
        result = pinyin;
    }
    return result;
}

- (BOOL)ms_matchPinYin:(NSString*)pinyin
{
    NSString* relpace = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger len = [relpace length]-[pinyin length];
    int i=0;
    while (i<=len)
    {
        int j=0;
        while (j<[pinyin length] && ([relpace dyzAtIndex:i+j] == [pinyin characterAtIndex:j] ||
               [relpace pinyinFirstLetterAtIndex:i+j] == [pinyin characterAtIndex:j]))
           j++;
        if (j == [pinyin length])
            return YES;
        i++;
    }
    return NO;
}  
@end
