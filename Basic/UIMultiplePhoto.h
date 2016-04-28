//
//  UIMultiplePhoto.h
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VjUIMultiplePhotoDatasource;


@protocol VjUIMultiplePhotoDatasource <NSObject>
@optional
- (void)leoMultipleImagesArray:(NSArray *)arr_images ;
- (void)leoSingleImageWith:(NSString *)fileName;
@end



@interface UIMultiplePhoto : UIButton
@property(weak,nonatomic) IBOutlet UIViewController<VjUIMultiplePhotoDatasource> *delegateMP;
+(void)removeCache;

@end
