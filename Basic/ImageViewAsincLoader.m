//
//  ImageViewAsincLoader.m
//  UIImageLoader
//
//  Created by Harminder on 23/01/13.
//  Copyright (c) 2013 Harminder. All rights reserved.
//


#import "ImageViewAsincLoader.h"

@interface ImageViewAsincLoader()



@end

@implementation ImageViewAsincLoader

@synthesize cachedisabled;
@synthesize imageAsincDelegate;

//@synthesize image;

+ (NSMutableDictionary *)cache
{
    static NSMutableDictionary *cache=nil;
    if(cache==nil)
        cache=[NSMutableDictionary dictionary];
    
    return cache;
}


- (UIImage *)cache:(NSURL *)url;
{
    return [[ImageViewAsincLoader cache] objectForKey:url.absoluteString];
}

- (void)setCache:(UIImage *)image url:(NSURL *)url
{
    if(image)
        [[ImageViewAsincLoader cache] setObject:image forKey:url.absoluteString];
}

+ (void)clearcache
{
    [[self cache] removeAllObjects];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        
    }
    return self;
    
}


- (void)addProgress
{
    if(progress==nil)
        
        progress=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    progress.frame=self.bounds;
    
    [self addSubview:progress];
    
    [self bringSubviewToFront:progress];
    
    [progress startAnimating];
}


-(void)downloadFromURL:(NSURL *)url
{
    if(!self.cachedisabled)
    {
        UIImage *img=[self cache:url];
        
        if(img)
        {
            self.image=img;
            return;
        }
    }
    
    imageData=[[NSMutableData alloc] init];
    
    
    [self addProgress];
    
    progress.hidden=NO;
    
    
    NSURLRequest *req=[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5000];
    
    [[NSURLConnection alloc] initWithRequest:req delegate:self];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [progress stopAnimating];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [imageData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [imageData appendData:data];
    
    self.image = [UIImage imageWithData:imageData];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.image=[UIImage imageWithData:imageData];
 
    if(!self.cachedisabled)
        [self setCache:self.image url:connection.currentRequest.URL];
    
    if ([self.imageAsincDelegate respondsToSelector:@selector(imageLoadedOfImageView:andImage:)])
        [self.imageAsincDelegate imageLoadedOfImageView:self andImage:self.image];
    
    [progress stopAnimating];
    progress.hidden=YES;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
