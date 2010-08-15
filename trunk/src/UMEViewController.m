//  Copyright 2010 Todd Ditchendorf
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <UMEKit/UMEViewController.h>
#import <UMEKit/UMENavigationController.h>
#import <UMEKit/UMENavigationItem.h>
#import <UMEKit/UMEBarButtonItem.h>
#import <QuartzCore/QuartzCore.h>
#import "UMEFlippedView.h"

@interface UMENavigationItem ()
@property (nonatomic, retain) UMENavigationBar *navigationBar;
@end

@interface UMEViewController ()
@property (nonatomic, readwrite, copy) NSString *nibName;
@property (nonatomic, readwrite, retain) NSBundle *nibBundle;
@property (nonatomic, readwrite, assign) UMEViewController *parentViewController;
@property (nonatomic, readwrite, retain) UMENavigationItem *navigationItem;
@property (nonatomic, readwrite, retain) UMENavigationController *navigationController;
@property (nonatomic, readwrite, retain) UMETabBarController *tabBarController;
@end

@implementation UMEViewController

- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
    if (self = [super init]) {
        self.nibName = name;
        self.nibBundle = bundle;
    }
    return self;
}


- (void)dealloc {
    [view removeFromSuperview];
    self.view = nil;
    self.nibName = nil;
    self.nibBundle = nil;
    self.title = nil;
    self.parentViewController = nil;
    self.navigationItem = nil;
    self.navigationController = nil;
    self.tabBarItem = nil;
    self.tabBarController = nil;
    [super dealloc];
}


- (void)loadView {
    if ([nibName length]) {
        NSNib *nib = [[[NSNib alloc] initWithNibNamed:nibName bundle:nibBundle] autorelease];
        if (![nib instantiateNibWithOwner:self topLevelObjects:nil]) {
            [NSException raise:@"UMEViewControllerFailedNibLoad" format:@"Could not load nib named %@", nibName];
        }
        
        // view is a top level nib object and therefore must be released by me.
        // since the view properperty retains the view, it must be released one more time to prevent a leak
        [view autorelease];

    } else {
        self.view = [[[UMEFlippedView alloc] initWithFrame:NSMakeRect(0, 0, MAXFLOAT, MAXFLOAT)] autorelease];
        [self.view setWantsLayer:NO];
    }
    
    [self viewDidLoad];
}


- (void)viewDidLoad {
    
}


- (void)viewDidUnload {
    
}


- (BOOL)isViewLoaded {
    return nil != view;
}


- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)viewDidAppear:(BOOL)animated {
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
}


- (void)viewDidDisappear:(BOOL)animated {
    
}


- (NSView *)view {
    if (![self isViewLoaded]) {
        [self loadView];
    }
    return view;
}


- (UMENavigationItem *)navigationItem {
    if (!navigationItem) {
        self.navigationItem = [[[UMENavigationItem alloc] initWithTitle:title] autorelease];
        navigationItem.navigationBar = self.navigationController.navigationBar;
    }
    return navigationItem;
}


- (void)setTitle:(NSString *)s {
    if (s != title) {
        [title autorelease];
        title = [s copy];
        
        [self.navigationItem setTitle:title];

        if (@selector(UMEBackItemClick:) == [self.navigationItem.backBarButtonItem action]) { // if the backBarButtonItem has been explicitly set, dont change the backBarButtonItem's title
            [self.navigationItem.backBarButtonItem setTitle:title];
        }
        
        [self.navigationItem.navigationBar setNeedsDisplay:YES];
    }
}

@synthesize view;
@synthesize nibName;
@synthesize nibBundle;
@synthesize title;
@synthesize parentViewController;
@synthesize navigationItem;
@synthesize hidesBottomBarWhenPushed;
@synthesize navigationController;
@synthesize tabBarItem;
@synthesize tabBarController;
@end
