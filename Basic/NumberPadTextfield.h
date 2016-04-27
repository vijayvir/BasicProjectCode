//
//  NumberPadTextfield.h
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VjNumberPadDatasource;


@protocol VjNumberPadDatasource <NSObject>
@optional
- (void)vjNumberPadDatasource:(UITextField *)fileName;
@end


@interface NumberPadTextfield : UITextField<UITextFieldDelegate>
@property(weak,nonatomic) IBOutlet id<VjNumberPadDatasource>datasource1;
@property (nonatomic) IBInspectable NSInteger maxLengh;
@end
