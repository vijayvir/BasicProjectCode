//
//  LeoCallbackAlertView.h
//  Liberty
//
//  Created by OSX on 08/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeoCallbackAlertView : UIAlertController






+(void)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  cancelButtonTitle:(NSString *)cancelButtonTitle andCompletionHandler: (void (^) (NSUInteger)) completionHandler otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
