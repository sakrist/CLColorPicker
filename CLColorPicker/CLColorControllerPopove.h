//
//  CLColorControllerPopove.h
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 29/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLColorControllerView : NSView

@end


@interface CLColorControllerPopove : NSViewController

@property (nonatomic, strong) id target;
@property (nonatomic) SEL selector;

@end
