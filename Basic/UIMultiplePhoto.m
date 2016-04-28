//
//  UIMultiplePhoto.m
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "UIMultiplePhoto.h"
#import  "LeoCallbackAlertView.h"


@implementation UIMultiplePhoto{
    NSMutableArray * arr_camera;
    
}
@synthesize delegateMP;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *longPressRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
        
          arr_camera = [[NSMutableArray alloc ] init];
        
        [self addGestureRecognizer:longPressRecognizer];
    }
    
    
    
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *longPressRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
         arr_camera = [[NSMutableArray alloc ] init];
        [self addGestureRecognizer:longPressRecognizer];
    }
    
    return self;
}
- (void) didTouchButton
{
    CGRect tempRect = self.layer.frame;
    
    tempRect.origin.x -= 2;
    tempRect.origin.y -= 2;
    
    tempRect.size.height += 4;
    tempRect.size.width += 4;
    
    self.layer.frame = tempRect;
    
    [self performSelector:@selector(removeEffect) withObject:nil afterDelay:0.2f];
}


- (void) removeEffect
{
    CGRect tempRect = self.layer.frame;
    
    tempRect.origin.x += 2;
    tempRect.origin.y += 2;
    
    tempRect.size.height -= 4;
    tempRect.size.width -= 4;
    
    self.layer.frame = tempRect;
}


-(void)camera{
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        imagePicker.allowsEditing = NO;
        
        if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                      UIImagePickerControllerSourceTypeCamera];
           
            
        }
        
        
        
        if (delegateMP)
            
            
        {
            
            
            
            [ (UIViewController*)delegateMP presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        
    }
}

-(void)photo{
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                  UIImagePickerControllerSourceTypePhotoLibrary];
        
        
     
        
    
        
        
        
        if (delegateMP)
            
            
        {
            
            
            
            [ (UIViewController*)delegateMP presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        
    }
}




+(NSString*)photoPath
{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/UIMultiplePhoto",NSTemporaryDirectory()]
                           isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/UIMultiplePhoto",NSTemporaryDirectory()]
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:nil];
    }
    
    
    return [NSString stringWithFormat:@"%@/UIMultiplePhoto",NSTemporaryDirectory()];
    
}
+(void)removeCache
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:[UIMultiplePhoto photoPath] error:nil];
    for (NSString *filename in fileArray)
    {
        
        [fileMgr removeItemAtPath:[[UIMultiplePhoto photoPath] stringByAppendingPathComponent:filename] error:NULL];
    }
    
    
}


-(void)addPhoto{
    
 
    [arr_camera removeAllObjects];
    
    
    [UIMultiplePhoto removeCache];
    
    
    [LeoCallbackAlertView initWithTitle:@"Select image ." message:@"" preferredStyle:UIAlertControllerStyleActionSheet  cancelButtonTitle:@"Cancel" andCompletionHandler:^(NSUInteger index)
     {
         if (index == 0)
         {
             
         }
         else if (index == 1)
         {
             [self camera];
             
         }
         else if (index == 2)
         {
             [self photo];
             
         }
         
         
         
     
       
         
     }
                      otherButtonTitles:@"Camera", @"Gallery", nil];
    
}



#pragma mark- pickerview Delegate


- (void)imagePickerController:(UIImagePickerController *)picker_t didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *fileName = [[UIMultiplePhoto photoPath] stringByAppendingPathComponent: [[[NSUUID UUID] UUIDString] stringByAppendingPathExtension:@"jpg"]] ;
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    NSData *imageD = UIImageJPEGRepresentation(image, .3);
    
    [imageD writeToFile:fileName atomically:YES];
    

    [arr_camera addObject:fileName];
    
    
    [picker_t dismissViewControllerAnimated:YES completion:^
    {
        
        if(picker_t.sourceType==UIImagePickerControllerSourceTypePhotoLibrary)
        {
        
            
            [LeoCallbackAlertView initWithTitle:@"Photo Library" message:@"Would you like to take more photo." preferredStyle:UIAlertControllerStyleActionSheet
                              cancelButtonTitle:@"NO" andCompletionHandler:^(NSUInteger index)
             {
                 if (index==0)
                 {
                     if (delegateMP)
                     {
                         if ([delegateMP respondsToSelector:@selector(leoMultipleImagesArray)])
                             [delegateMP leoMultipleImagesArray:arr_camera];
                     }
                     
                     
                     
                 }
                 if (index==1)
                 {
                     [self photo];
                 }
                 
             } otherButtonTitles:@"YES", nil];
            
        }
        else{
            [LeoCallbackAlertView initWithTitle:@"Camera" message:@"Would you like to take more photo." preferredStyle:UIAlertControllerStyleActionSheet
                              cancelButtonTitle:@"NO" andCompletionHandler:^(NSUInteger index)
             {
                 if (index==0)
                 {
                     if (delegateMP)
                     {
                         if ([delegateMP respondsToSelector:@selector(leoMultipleImagesArray)])
                             [delegateMP leoMultipleImagesArray:arr_camera];
                     }
                     
                     
                     
                 }
                 if (index==1)
                 {
                     [self camera];
                 }
                 
             } otherButtonTitles:@"YES", nil];
        }
        
        
        
        
        
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
