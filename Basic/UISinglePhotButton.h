//
//  UISinglePhotButton.h
//  Liberty
//
//  Created by OSX on 23/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol VjUISinglePhotButtonDatasource;


@protocol VjUISinglePhotButtonDatasource <NSObject>
@optional

- (void)vjUISinglePhoto:(UIButton*)button filepath:(NSString *)fileName;

@end



@interface UISinglePhotButton : UIButton<UIImagePickerControllerDelegate>

@property(weak,nonatomic) IBOutlet id<VjUISinglePhotButtonDatasource>delegateSP;
@end
