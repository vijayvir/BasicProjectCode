//
//  ScrollViewImages.h
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VJScrollViewImagesDatasource;
@protocol VJScrollViewImagesDatasource <NSObject>
@optional
@end
@interface ScrollViewImages : UIScrollView

@property(weak,nonatomic) IBOutlet id <VJScrollViewImagesDatasource>delegateSV;
@property(nonatomic,strong )NSArray *arr_images;
@end
