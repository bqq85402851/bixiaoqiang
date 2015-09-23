//
//  AppDelegate.m
//  GeTui
//
//  Created by 杨汉池 on 15/9/21.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import "GeTuiSdkError.h"
#import "ViewController.h"

NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";
@interface AppDelegate ()<GeTuiSdkDelegate>
{
    ViewController*_viewController;
    NSString*_deviceToken;
    NSString*_clientId;
    NSString*_payloadId;
}
@end

@implementation AppDelegate
- (void)registerRemoteNotification
    {
#ifdef __IPHONE_8_0
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        } else {
            UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
        }
#else
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    }

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self startSdkWith:@"GGM5vhPujj6kYWtv9UUtyA" appKey:@"Yx5bl7bkFZA4HqIyMtw4Y5" appSecret:@"Yvnn4w7neF95PsPgK15zN9"];
    
    [self registerRemoteNotification];
    NSDictionary*message=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString*payloadMsg=[message objectForKey:@"payload"];
        NSString*record=[NSString stringWithFormat:@"APN%@,%@",[NSDate date],payloadMsg];
    }
    _viewController=[[ViewController alloc]init];
    self.window.rootViewController=_viewController;
    return YES;
}
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    NSError *err = nil;
    //[1-1]:通过 AppId、 appKey 、appSecret 启动 SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置地理围栏功能,开启 LBS 定位服务和是否允许 SDK 弹出用户定位请求,请求
   // NSLocationAlwaysUsageDescription 权限,如果 UserVerify 设置为 NO,需第三方负责提示用户定位授权。 [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if (err) {
        NSLog(@"%@",[err localizedDescription]);
     //   [_viewController logMsg:[NSString stringWithFormat:@"%@", [err localizedDescription]]];
    }
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString*token=[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken=[token stringByReplacingOccurrencesOfString:@"" withString:@"" ];
    NSLog(@"deviceToke:%@",_deviceToken);
    [GeTuiSdk registerDeviceToken:_deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [GeTuiSdk registerDeviceToken:@""];
}
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
    if (_deviceToken) {
        [GeTuiSdk registerDeviceToken:_deviceToken];
    }
}
-(void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId fromApplication:(NSString *)appId{
    NSData*payload=[GeTuiSdk retrivePayloadById:payloadId];
    NSString*payloadMsg=nil;
    if (payload) {
        payloadMsg=[[NSString alloc]initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
  //  NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++_lastPaylodIndex, [self formateTime:[NSDate date]], payloadMsg];
    NSLog(@"task id : %@, messageId:%@", taskId, aMsgId);
}
-(void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result{
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d",messageId, result];
    NSLog(@"%@",record);
}
-(void)GeTuiSdkDidOccurError:(NSError *)error{
    NSLog(@"%@",[error localizedDescription]);
}
-(void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus{
    NSLog(@"%u",aStatus);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [GeTuiSdk enterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
