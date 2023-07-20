//
// Created by lee on 2023/7/20.
//

#import <Foundation/Foundation.h>


@interface FlexInjectCenter : NSObject
@property NSMutableArray *injectApps;
@property NSMutableDictionary *pref;
+ (instancetype)shareInstances;

- (void)loadPref;

- (void)savePref;

- (void)refreshAllApps;

- (NSNumber *)getValueByBundleId:(NSString *)bundleId;

- (void)changeValue:(NSNumber *)value byBundleId:(NSString *)bundleId;
@end


@interface LSApplicationWorkspace : NSObject
+ (id)defaultWorkspace;
- (NSArray *)applicationsOfType:(unsigned int)appType;
@end

@interface LSApplicationProxy : NSObject
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *bundleType;
@property (nonatomic, readonly) NSURL *bundleURL;
@property (nonatomic, readonly) NSString *applicationType;
@property (nonatomic, readonly) NSString *primaryIconName;
@property (nonatomic, readonly) bool launchProhibited;
@property (nonatomic, readonly) NSArray *appTags;
// @property (getter=isPlaceholder, nonatomic, readonly) bool placeholder;
- (id)localizedName;
- (bool)isPlaceholder;
- (bool)isLaunchProhibited;
@end