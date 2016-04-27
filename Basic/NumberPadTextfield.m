//
//  NumberPadTextfield.m
//  Liberty
//
//  Created by OSX on 18/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "NumberPadTextfield.h"

@implementation NumberPadTextfield
@synthesize datasource1;

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
       
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        [keyboardDoneButtonView sizeToFit];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(numberPaddoneClicked:)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
        
        self.inputAccessoryView = keyboardDoneButtonView;
    
        [self addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    }
    
    
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
      
    }
    return self;
}

-(void)numberPaddoneClicked:(id)sender
{
    if (datasource1)
    {
        
        [datasource1 vjNumberPadDatasource:self];
        
    }
    
    
}



#pragma mark - 

-(void)textFieldDidChange:(id)semder
{
    if (self.text.length > self.maxLengh)
    {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.text];
        [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0,self.maxLengh-1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.maxLengh,self.text.length-self.maxLengh -1)];
   
        self.attributedText = string;
        
    }
    
    else
    {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.text];
       
        [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0,self.text.length)];
        
        self.attributedText = string;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
    
}
@end


