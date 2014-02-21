//
//  TestANe.m
//  DFPExample
//
//  Created by Emil Atanasov on 11/25/11.
//  Copyright 2011  Lancelotmobile ltd. All rights reserved.
//

#import "AdHolder.h"

@interface AdHolder ()
  - (void)showAdPanel: (CGRect) rect;
@end

@implementation AdHolder

@synthesize isInRealMode;
@synthesize viewFrame;
@synthesize unitId;
@synthesize context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = viewFrame;
    [self showAdPanel:CGRectMake(0.0,0.0,viewFrame.size.width,viewFrame.size.height)];
}

- (void) refresh
{
    if(_bannerView)
    {
        if(isInRealMode)
        {
            [_bannerView loadRequest:[GADRequest request]];
        }
    }
}

- (void)showAdPanel: (CGRect) rect
{
    CGPoint origin = CGPointMake(0,0);
    _bannerView = [[[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner origin:origin] autorelease];
    _bannerView.frame = rect;
    _bannerView.adUnitID = unitId;
    _bannerView.rootViewController = self;
    _bannerView.delegate = self;
    [self.view addSubview:_bannerView];
    if(isInRealMode)
    {
        [_bannerView loadRequest:[GADRequest request]];
    }
    else
    {
        GADRequest * request = [GADRequest request];
        request.testDevices = @[GAD_SIMULATOR_ID];
        [_bannerView loadRequest:request];
    }
    NSLog(@"Ad initialized");
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    NSLog(@"Ad adViewWillDismissScreen");
    self.view.hidden = YES;
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
     NSLog(@"Ad adViewDidDismissScreen");
     self.view.frame = viewFrame;
     self.view.hidden = NO;
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSString *event_name = @"adClicked";
    NSString *event_level = @"adClicked";
    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSString *event_name = @"bannerFailed";
    NSString *event_level = @"bannerFailed";
    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSString *event_name = @"bannerReceived";
    NSString *event_level = @"bannerReceived";
    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _bannerView.delegate = nil;
    [_bannerView release];
    _bannerView = nil;
}

- (void)dealloc
{
    [super dealloc];
    [_bannerView release];
    _bannerView = nil;
    context = NULL;
    self.unitId = nil;
}

@end
