//
//  ImageViewAsincLoader.h
//  UIImageLoader
//
//  Created by Harminder on 23/01/13.
//  Copyright (c) 2013 Harminder. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ImageViewAsincLoader;


@protocol ImageAsincDelegate <NSObject>

- (void) imageLoadedOfImageView: (ImageViewAsincLoader *)imgView andImage:(UIImage *)image;

@end


@interface ImageViewAsincLoader : UIImageView<NSURLConnectionDelegate>
{
    UIActivityIndicatorView * progress;
    
    NSMutableData *imageData;
}



@property(nonatomic,assign)BOOL cachedisabled;
@property (nonatomic, retain) id <ImageAsincDelegate> imageAsincDelegate;


-(void)downloadFromURL:(NSURL *)url;

+(void)clearcache;

@end
