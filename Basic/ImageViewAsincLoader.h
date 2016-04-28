
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
