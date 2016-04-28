//
//  ScrollViewImages.m
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "ScrollViewImages.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "LeoKit.h"

@implementation ScrollViewImages
{
    UIPageControl * pageControl;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    
    
    
 
    if (self.delegateSV)
    {
    
        
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(150, 250 , 100, 36)];
        pageControl.backgroundColor=[UIColor whiteColor];
        
        [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
        
        [ (UIView*)self.delegateSV  addSubview:pageControl];
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
       self.pagingEnabled=YES;
         self.delegate=self;
//        UITapGestureRecognizer *longPressRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
//        
//        [self addGestureRecognizer:longPressRecognizer];
        
     
        
    }
    
    
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
          self.pagingEnabled=YES;
        
      
        
//        UITapGestureRecognizer *longPressRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
//        
//        [self addGestureRecognizer:longPressRecognizer];
    }
    
    return self;
}

-(void)setArr_images:(NSArray *)arr_imagess
{
    _arr_images = arr_imagess;
    
    if (pageControl) {
          pageControl.numberOfPages=_arr_images.count;
    }
  
    [self  addImagesToScrollView];
    
}

-(void)addImagesToScrollView
{
    int xOffset = 0;
    
    
    for (ImageViewAsincLoader * view in self.subviews)
    {
        
        if ([[view class] isKindOfClass:[ImageViewAsincLoader class]])
        {
            [view removeFromSuperview];
            
        }

    }
   
    
    
    for (id asset  in self.arr_images)
        
        
    {
        
        ImageViewAsincLoader  *imrg = [[ImageViewAsincLoader alloc] initWithFrame:CGRectMake(xOffset,0,self.frame.size.width, 200)];
        
        
     
         imrg.image = [UIImage imageNamed:asset];
            
            
         [imrg downloadFromURL:[NSURL URLWithString:(NSString*)asset ]];
       
        
      
        // img.image = (UIImage*) [imagesarray objectAtIndex:index];
        
        // img.contentMode = UIViewContentModeScaleToFill;
        
    
        
        [self addSubview:imrg];
        
        xOffset+=self.frame.size.width;
    }
    
    
    
    
    
    self.contentSize = CGSizeMake((self.frame.size.width)*self.arr_images.count  ,200);
    
}



- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    CGFloat viewWidth = _scrollView.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((_scrollView.contentOffset.x - viewWidth/50) / viewWidth) +1;
    if (pageControl) {
    pageControl.currentPage=pageNumber;
    }
}

- (void)pageChanged {
    
    NSInteger pageNumber = pageControl.currentPage;
    
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [self scrollRectToVisible:frame animated:YES];
}

@end
