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

#import <UMEKit/UMEBarButtonItem.h>
#import "UMEBarButtonItemButton.h"
#import "UMEFlippedView.h"

#define CUSTOM_VIEW_FLAG 500
#define MIN_HEIGHT 44
#define MIN_WIDTH 40

@interface UMEBarButtonItem ()
- (void)sizeToFit;
- (void)layout;
@property (nonatomic, retain) NSButton *button;
@property (nonatomic) UMEBarStyle barStyle;            // default is UMEBarStyleDefault
@property (nonatomic, getter=isSpace) BOOL space;
@property (nonatomic, getter=isFlexible) BOOL flexible;
@end

@implementation UMEBarButtonItem

- (id)initWithBarButtonSystemItem:(UMEBarButtonSystemItem)systemItem target:(id)t action:(SEL)sel {
    NSString *aTitle = nil;
    NSString *imgPath = nil;
    NSBundle *b = [NSBundle bundleForClass:[UMEBarButtonItem class]];
    UMEBarButtonItemStyle aStyle = UMEBarButtonItemStylePlain;
    NSCellImagePosition imgPos = NSNoImage;
    
    switch (systemItem) {
        case UMEBarButtonSystemItemDone:
            aTitle = NSLocalizedString(@"Done", @"");
            aStyle = UMEBarButtonItemStyleDone;
            break;
        case UMEBarButtonSystemItemCancel:
            aTitle = NSLocalizedString(@"Cancel", @"");
            break;
        case UMEBarButtonSystemItemEdit:  
            aTitle = NSLocalizedString(@"Edit", @"");
            break;
        case UMEBarButtonSystemItemSave:  
            aTitle = NSLocalizedString(@"Save", @"");
            aStyle = UMEBarButtonItemStyleDone;
            break;
        case UMEBarButtonSystemItemAdd:
            aTitle = NSLocalizedString(@"Add", @"");
            break;
        case UMEBarButtonSystemItemFlexibleSpace:
            self.space = YES;
            self.flexible = YES;
            imgPath = [b pathForImageResource:@""];
            break;
        case UMEBarButtonSystemItemFixedSpace:
            self.space = YES;
            imgPath = [b pathForImageResource:@""];
            break;
        case UMEBarButtonSystemItemCompose:
            imgPath = [b pathForImageResource:@"barbutton_system_item_compose"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemReply:
            imgPath = [b pathForImageResource:@"barbutton_system_item_reply"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemAction:
            imgPath = [b pathForImageResource:@"barbutton_system_item_action"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemOrganize:
            imgPath = [b pathForImageResource:@"barbutton_system_item_organize"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemBookmarks:
            imgPath = [b pathForImageResource:@"barbutton_system_item_bookmarks"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemSearch:
            imgPath = [b pathForImageResource:@"barbutton_system_item_search"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemRefresh:
            imgPath = [b pathForImageResource:@"barbutton_system_item_refresh"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemStop:
            imgPath = [b pathForImageResource:@"barbutton_system_item_stop"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemCamera:
            imgPath = [b pathForImageResource:@"barbutton_system_item_camera"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemTrash:
            imgPath = [b pathForImageResource:@"barbutton_system_item_trash"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemPlay:
            imgPath = [b pathForImageResource:@"barbutton_system_item_play"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemPause:
            imgPath = [b pathForImageResource:@"barbutton_system_item_pause"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemRewind:
            imgPath = [b pathForImageResource:@"barbutton_system_item_rewind"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemFastForward:
            imgPath = [b pathForImageResource:@"barbutton_system_item_fastforward"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemPrev:
            imgPath = [b pathForImageResource:@"barbutton_system_item_prev"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemNext:
            imgPath = [b pathForImageResource:@"barbutton_system_item_next"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemUndo:
            imgPath = [b pathForImageResource:@"barbutton_system_item_reply"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemRedo:
            imgPath = [b pathForImageResource:@"barbutton_system_item_redo"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemUser:
            imgPath = [b pathForImageResource:@"barbutton_system_item_user"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemEveryone:
            imgPath = [b pathForImageResource:@"barbutton_system_item_everyone"];
            imgPos = NSImageOnly;
            break;
        default:
            NSAssert(0, @"Unknown UMEBarButtonSystemItem");
            break;
    }
    
    if (self.isSpace) {
        self = [self initWithCustomView:[[[NSView alloc] initWithFrame:NSZeroRect] autorelease]];
    } else {
        self = [self initWithTitle:aTitle style:aStyle target:t action:sel];
        if ([imgPath length]) {
            self.image = [[[NSImage alloc] initWithContentsOfFile:imgPath] autorelease];
        }
        [button setImagePosition:imgPos];
    }
    return self;
}


- (id)initWithCustomView:(NSView *)v {
    self = [self initWithTitle:nil style:CUSTOM_VIEW_FLAG target:nil action:nil];
    self.customView = v;
    return self;
}


- (id)initWithImage:(NSImage *)img style:(UMEBarButtonItemStyle)s target:(id)t action:(SEL)sel {
    self = [self initWithTitle:nil style:s target:t action:sel];
    self.image = img;
    [button setImagePosition:NSImageOnly];
    return self;
}


- (id)initWithTitle:(NSString *)aTitle style:(UMEBarButtonItemStyle)aStyle target:(id)aTarget action:(SEL)sel {
    if (self = [super init]) {
        
        if (CUSTOM_VIEW_FLAG == aStyle) {
            self.style = UMEBarButtonItemStylePlain;
        } else {
            self.button = [[[UMEBarButtonItemButton alloc] initWithFrame:NSZeroRect] autorelease];
            [button setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
            [(UMEBarButtonItemButton *)button setItem:self];
            self.style = aStyle;
        }
        
        self.title = aTitle;
        self.target = aTarget;
        self.action = sel;
        self.barStyle = UMEBarStyleDefault;
        
        if (CUSTOM_VIEW_FLAG != aStyle) {
            self.customView = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
        }
    }
    return self;
}


- (void)dealloc {
    [button removeFromSuperview];
    [customView removeFromSuperview];
    self.customView = nil;
    self.button = nil;
    self.target = nil;
    self.action = nil;
    [super dealloc];
}


- (void)sizeToFit {
    if (button) {
        [button sizeToFit];
        //[button setFrameOrigin:NSZeroPoint];
        [customView setFrameSize:[button frame].size];
    } else {
        if (self.isFlexible) return;
        
        if ([customView respondsToSelector:@selector(sizeToFit)]) {
            [customView performSelector:@selector(sizeToFit)];
        } else {
            NSRect frame = [customView frame];
            if (frame.size.height < MIN_HEIGHT) {
                frame.size.height = MIN_HEIGHT;
            }
            if (frame.size.width < MIN_WIDTH) {
                frame.size.width = MIN_WIDTH;
            }
            [customView setFrame:frame];
        }
    }
}


- (void)layout {
    if (button) {
        [button setFrame:[customView bounds]];
    } else {
    }
}


- (void)setEnabled:(BOOL)yn {
    [super setEnabled:yn];
    [button setEnabled:yn];
}


- (CGFloat)width {
    [self sizeToFit];
    return NSWidth([customView frame]);
}


- (id)target {
    return [button target];
}


- (void)setTarget:(id)t {
    [button setTarget:t];
}


- (SEL)action {
    return [button action];
}


- (void)setAction:(SEL)sel {
    [button setAction:sel];
}


- (void)setTitle:(NSString *)aTitle {
    [super setTitle:aTitle];
    [button setTitle:aTitle];
}


- (void)setImage:(NSImage *)img {
    [super setImage:img];
    [button setImage:img];
}


- (void)setCustomView:(NSView *)v {
    if (customView != v) {
        [customView autorelease];
        customView = [v retain];
        
        [customView addSubview:button];
    }
}

@synthesize customView;
@synthesize button;
@synthesize style;
@synthesize width;
@synthesize barStyle;
@synthesize space;
@synthesize flexible;
@end
