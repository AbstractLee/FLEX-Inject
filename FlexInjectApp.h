//
// Created by lee on 2023/7/20.
//

#import <Foundation/Foundation.h>
#import "FlexInjectCenter.h"

@interface FlexInjectApp : NSObject
@property LSApplicationProxy *applicationProxy;
- (instancetype)initWithProxy:(LSApplicationProxy *)proxy;
- (void)switchChanged:(NSNumber *)value;
- (NSNumber *)getSwitchValue;
@end