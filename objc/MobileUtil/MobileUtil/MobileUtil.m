//
//  MobileUtil.m
//  MobileUtil
//
//  Created by shaorui on 13-4-12.
//  Copyright (c) 2013年 shaorui. All rights reserved.
//

#import "MobileUtil.h"
#import "FlashRuntimeExtensions.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GADBannerView.h"

@implementation MobileUtil

GADBannerView *_banner;
NSString *bannerUnitId;
NSString *interstitialUnitId;
BOOL inRealMode;
FREContext aContext;
CGRect bannerRect1;
CGRect bannerRect2;
CGRect bannerRect3;
CGRect bannerRect4;

- (void)sendSMS:(NSString *)phonenumber mes:(NSString *)message
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
    {
        
        picker.messageComposeDelegate = self;
        NSArray *array = [NSArray arrayWithObject:phonenumber];
        picker.recipients = array;
        picker.body = message;
        
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:picker animated:YES];
        [picker release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备没有短信功能" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
didFinishWithResult:(MessageComposeResult)result {
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"发送取消");
            break;
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        default:
            NSLog(@"其它");
            break;
    }
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)shake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)admobInit:(NSString *)bannerKey key2:(NSString *)interstitialKey ist:(int32_t)isTest
{
    id delegate = [[UIApplication sharedApplication] delegate];
    UIWindow *stage = [delegate window];
    if(isTest == 1)
        inRealMode = NO;
    else
        inRealMode = YES;
    bannerUnitId = bannerKey;
    interstitialUnitId = interstitialKey;
    CGPoint origin = CGPointMake(0,0);
    _banner = [[[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner origin:origin] autorelease];
    _banner.adUnitID = bannerUnitId;
    _banner.delegate = self;
    _banner.rootViewController = stage.rootViewController;
}

- (void)admobSetOrientation:(int32_t)oindex
{
    return;
    FREDispatchStatusEventAsync(aContext, (uint8_t*)[@"卧槽屏幕旋转" UTF8String], (uint8_t*)[@"" UTF8String]);
    if(_banner == nil)
        return;
    if(oindex == 1)
    {
        _banner.transform = CGAffineTransformMakeRotation(0);
        _banner.frame = bannerRect1;
    }
    else if(oindex == 2)
    {
        _banner.transform = CGAffineTransformMakeRotation(M_PI);
        _banner.frame = bannerRect2;
    }
    else if(oindex == 3)
    {
        _banner.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _banner.frame = bannerRect3;
    }
    else if(oindex == 4)
    {
        _banner.transform = CGAffineTransformMakeRotation(M_PI / 2);
        _banner.frame = bannerRect4;
    }
}

- (void)admobShowBanner:(int32_t)x y:(int32_t)yValue w:(int32_t)wValue h:(int32_t)hValue bt:(int32_t)bannerType
{
    //CGRect rect_screen = [[UIScreen mainScreen] bounds];
    //CGSize size_screen = rect_screen.size;
    //CGFloat scale_screen = [UIScreen mainScreen].scale;
    //CGRect stageFrame = CGRectMake(0,0,size_screen.width*scale_screen,size_screen.height*scale_screen);
    //CGSize stageSize = stageFrame.size;
    //bannerRect1 = CGRectMake(x,yValue,wValue,hValue);
    //bannerRect2 = CGRectMake(stageSize.width-x-wValue,stageSize.height-yValue-hValue,wValue,hValue);
    //bannerRect3 = CGRectMake(stageSize.width-yValue-hValue-(wValue-hValue)/2,x+(wValue-hValue)/2,hValue,wValue);
    //bannerRect4 = CGRectMake(stageSize.width-yValue-hValue-(wValue-hValue)/2,x+(wValue-hValue)/2,hValue,wValue);
    if(_banner)
    {
        _banner.frame = bannerRect1;
        id delegate = [[UIApplication sharedApplication] delegate];
        UIWindow *stage = [delegate window];
        UIView *flashView = [stage subviews][0];
        [flashView addSubview:_banner];
        if(inRealMode)
        {
            [_banner loadRequest:[GADRequest request]];
        }
        else
        {
            GADRequest * request = [GADRequest request];
            request.testDevices = @[GAD_SIMULATOR_ID];
            [_banner loadRequest:request];
        }
        NSLog(@"Ad initialized");
    }
}

- (void)admobHideBanner
{
    [_banner removeFromSuperview];
}

- (void)admobShowInterstitial
{
    
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSString *event_name = @"adClicked";
    NSString *event_level = @"adClickedLevel";
    FREDispatchStatusEventAsync(aContext, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSString *event_name = @"bannerFailed";
    NSString *event_level = @"bannerFailedLevel";
    FREDispatchStatusEventAsync(aContext, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSString *event_name = @"bannerReceived";
    NSString *event_level = @"bannerReceivedLevel";
    FREDispatchStatusEventAsync(aContext, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)dealloc {
    [super dealloc];
}

@end

/* techmxExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml
 */
void techmxExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"Entering sendmessageExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TMXContextInitializer;
    *ctxFinalizerToSet = &TMXContextFinalizer;
    
    NSLog(@"Exiting sendmessageExtInitializer()");
}

/* techmxExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml
 */
void techmxExtFinalizer(void* extData)
{
    NSLog(@"Entering sendmessageExtFinalizer()");
    
    // Nothing to clean up.
    NSLog(@"Exiting sendmessageExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void TMXContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    aContext = ctx;
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] =
    {
       MAP_FUNCTION(sendSMS, NULL),
       MAP_FUNCTION(shake, NULL),
       MAP_FUNCTION(admobInit, NULL),
       MAP_FUNCTION(admobSetOrientation, NULL),
       MAP_FUNCTION(admobShowBanner, NULL),
       MAP_FUNCTION(admobHideBanner, NULL),
       MAP_FUNCTION(admobShowInterstitial, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    NSLog(@"Exiting ContextInitializer()");
}

NSString * getStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

FREObject creatFREBool(BOOL value)
{
    FREObject fo;
    FRENewObjectFromBool(value, &fo);
    return fo;
}

ANE_FUNCTION(sendSMS)
{
    NSString * num = getStringFromFREObject(argv[0]);
    NSString * msg = getStringFromFREObject(argv[1]);
    MobileUtil *message = [[MobileUtil alloc] init];
    [message sendSMS: num mes:msg];
    return creatFREBool(YES);
}
ANE_FUNCTION(shake)
{
    MobileUtil *message = [[MobileUtil alloc] init];
    [message shake];
    return creatFREBool(YES);
}
ANE_FUNCTION(admobInit)
{
    NSString * bannerKey = getStringFromFREObject(argv[0]);
    NSString * interstitialKey = getStringFromFREObject(argv[1]);
    int32_t isTest;
    FREGetObjectAsInt32(argv[2], &isTest);
    MobileUtil *message = [[MobileUtil alloc] init];
    [message admobInit: bannerKey key2:interstitialKey ist:isTest];
    return creatFREBool(YES);
}
ANE_FUNCTION(admobSetOrientation)
{
    int32_t orientationIndex;
    FREGetObjectAsInt32(argv[0], &orientationIndex);
    MobileUtil *message = [[MobileUtil alloc] init];
    [message admobSetOrientation: orientationIndex];
    return creatFREBool(YES);
}
ANE_FUNCTION(admobShowBanner)
{
    int32_t x;
    int32_t y;
    int32_t w;
    int32_t h;
    int32_t bt;
    FREGetObjectAsInt32(argv[0], &x);
    FREGetObjectAsInt32(argv[1], &y);
    FREGetObjectAsInt32(argv[2], &w);
    FREGetObjectAsInt32(argv[3], &h);
    FREGetObjectAsInt32(argv[4], &bt);
    MobileUtil *message = [[MobileUtil alloc] init];
    [message admobShowBanner:x y:y w:w h:h bt:bt];
    return creatFREBool(YES);
}
ANE_FUNCTION(admobHideBanner)
{
    MobileUtil *message = [[MobileUtil alloc] init];
    [message admobHideBanner];
    return creatFREBool(YES);
}
ANE_FUNCTION(admobShowInterstitial)
{
    MobileUtil *message = [[MobileUtil alloc] init];
    [message admobShowInterstitial];
    return creatFREBool(YES);
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void TMXContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");
    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}
