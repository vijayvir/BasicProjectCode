//
//  DatePickerTextField.h
//  Liberty
//
//  Created by OSX on 22/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VjNumberPadDatasource;


@protocol VjNumberPadDatasource <NSObject>
@optional
- (void)vjDatePickerClickOnDoneBytton:(UITextField *)fileName;
- (void)vjDatePickerValueChanged:(NSString *)date  withTextField:(UITextField*)fields ;

@end

@interface DatePickerTextField : UITextField


@property(weak,nonatomic) IBOutlet id<VjNumberPadDatasource>delegateDP;
@property (nonatomic) IBInspectable NSString * donebt;
@end
