//
//  TimePickerTextField.h
//  Liberty
//
//  Created by OSX on 23/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VjTimePickerDatasource;


@protocol VjTimePickerDatasource <NSObject>
@optional
- (void)vjTimePickerClickOnDoneBytton:(UITextField *)fileName;
- (void)vjTimePickerValueChanged:(NSString *)date  withTextField:(UITextField*)fields ;

@end

@interface TimePickerTextField : UITextField


@property(weak,nonatomic) IBOutlet id<VjTimePickerDatasource>delegateTP;
@end
