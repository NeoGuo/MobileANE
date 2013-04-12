//
//  MobileUtil.m
//  MobileUtil
//
//  Created by shaorui on 13-4-12.
//  Copyright (c) 2013年 shaorui. All rights reserved.
//

#import "MobileUtil.h"
#import "FlashRuntimeExtensions.h"

@implementation MobileUtil

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
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] =
    {
       MAP_FUNCTION(sendSMS, NULL),
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
