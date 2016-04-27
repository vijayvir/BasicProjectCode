//
//  UISinglePhotButton.m
//  Liberty
//
//  Created by OSX on 23/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "UISinglePhotButton.h"
#import "LeoKit.h"


@implementation UISinglePhotButton
@synthesize delegateSP;

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


#pragma mark -


-(void)addPhoto{
    
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
    for (NSString *filename in fileArray)
    {
        
        [fileMgr removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename] error:NULL];
    }
    
    
    [LeoCallbackAlertView initWithTitle:@"Select image ." message:@"" preferredStyle:UIAlertControllerStyleActionSheet  cancelButtonTitle:@"Cancel" andCompletionHandler:^(NSUInteger index)
     {
         if (index == 0)
         {
             
         }
         else
         {
             UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
             
             imagePicker.delegate = self;
             
             imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
             
             
             imagePicker.allowsEditing = NO;
             if (index == 1)
             {
                 if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
                 {
                     imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                     
                     imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                               UIImagePickerControllerSourceTypeCamera];
                     
                 }
             }
             else if (index == 2)
             {
                 imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                 
                 imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                           UIImagePickerControllerSourceTypePhotoLibrary];
                 
                 
             }
             
             if (delegateSP)
                 
                 
             {
                 
                 
                 
                 [ (UIViewController*)delegateSP presentViewController:imagePicker animated:YES completion:^{
                     
                 }];
             }
             
         }
         
     }
                      otherButtonTitles:@"Camera", @"Gallery", nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker_t didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *fileName = [NSTemporaryDirectory() stringByAppendingPathComponent: [[[NSUUID UUID] UUIDString] stringByAppendingPathExtension:@"jpg"]] ;
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    NSData *imageD = UIImageJPEGRepresentation(image, .3);
    
    [imageD writeToFile:fileName atomically:YES];
    
    if (delegateSP)
    {
        if ([delegateSP respondsToSelector:@selector(vjUISinglePhoto:filepath:)]) {
            [delegateSP vjUISinglePhoto:self filepath:fileName];
            
        }
        

    }
    [picker_t dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
