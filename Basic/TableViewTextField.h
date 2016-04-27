//
//  TableViewTextField.h
//  Kwipshare
//
//  Created by iOS Developer on 23/04/16.
//  Copyright © 2016 Hocrox. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VJTableViewTextFieldDatasource;


@protocol VJTableViewTextFieldDatasource <NSObject>
-(NSArray*)vjTableViewTextFieldKeyboardWillshow:(UITextField*)textfield ;
-(void)vjTableViewTextFieldKeyboardWillhide:(UITextField*)textfield ;
-(NSString *)vjTableViewTextField:(UITextField*)textfield withObject:(id)sender;

@optional
- (void)vjTableViewTextField:(UITextField *)fileName;
-(void)vjTextFieldEnterDone:(UITextField*)textfield withObject:(id)sender;

@end


@interface TableViewTextField : UITextField<UIPickerViewDataSource, UIPickerViewDelegate>
@property(weak,nonatomic) IBOutlet id<VJTableViewTextFieldDatasource>delegateTV;
@property (nonatomic) IBInspectable NSString * title;

@end
