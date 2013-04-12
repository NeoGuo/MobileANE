//
//  MobileUtil.h
//  MobileUtil
//
//  Created by shaorui on 13-4-12.
//  Copyright (c) 2013年 shaorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "FlashRuntimeExtensions.h"

@interface MobileUtil : UIViewController<MFMessageComposeViewControllerDelegate>

@end
NSString * getStringFromFREObject(FREObject obj);
FREObject creatFREBool(BOOL value);

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }

/* techmxExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml
 */
void techmxExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

/* techmxExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml
 */
void techmxExtFinalizer(void* extData);

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void TMXContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void TMXContextFinalizer(FREContext ctx);

/* This is a sample function that is being included as part of this template.
 *
 * Users of this template are expected to change this and add similar functions
 * to be able to call the native functions in the ANE from their ActionScript code
 */
ANE_FUNCTION(sendSMS);