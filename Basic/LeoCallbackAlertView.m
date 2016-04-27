//
//  LeoCallbackAlertView.m
//  Liberty
//
//  Created by OSX on 08/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "LeoCallbackAlertView.h"

@implementation LeoCallbackAlertView



+(void)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle   cancelButtonTitle:(NSString *)cancelButtonTitle andCompletionHandler: (void (^) (NSUInteger)) completionHandler otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertController* alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:preferredStyle];
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:cancelButtonTitle
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           completionHandler([alertController.actions indexOfObject:action]);
                                       }];
        [alertController addAction:cancelAction];
    }
    
   
    
    va_list args;
    
    
    va_start(args, otherButtonTitles);
    
    
    for (NSString *btnTitle = otherButtonTitles; btnTitle != nil; btnTitle = va_arg(args, NSString *))
    {
        UIAlertAction *simple = [UIAlertAction
                                   actionWithTitle:btnTitle
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                     
                                       completionHandler([alertController.actions indexOfObject:action]);
                                       
                                       NSLog(@"OK action");
                                   }];
        
        [alertController addAction:simple];
    }
    
    
    va_end(args);
    
   // UIApplication.sharedApplication().keyWindow?.rootViewController?
  [ [UIApplication sharedApplication ].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
