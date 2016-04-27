//
//  DatePickerTextField.m
//  Liberty
//
//  Created by OSX on 22/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "DatePickerTextField.h"

#define dateformatVJ2 @"yyyy-MM-dd"
#define dateformatVJ @"dd-MMM-yyyy"


@implementation DatePickerTextField
{
    UIDatePicker *datePicker;
    
}
@synthesize delegateDP;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.font = [UIFont fontWithName:@"OpenSans" size:self.font.pointSize];
    
    [super awakeFromNib];
}

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
        
       datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:dateformatVJ];
    
        
       //datePicker.date = [dateFormatter dateFromString:self.text];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = 6;
        self.inputView = datePicker;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
       
    }
    
    
    
    return self;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateformatVJ];
    
    
    if (self.text.length>0)
    {
        if ( ![dateFormatter dateFromString:self.text])
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:dateformatVJ2];
             datePicker.date = [dateFormatter2 dateFromString:self.text];
            return;
            
        }
        
           datePicker.date = [dateFormatter dateFromString:self.text];
    }
 
    
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
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
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:dateformatVJ];
        
        
      //  datePicker.date = [NSDate date];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = 6;
        self.inputView = datePicker;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}
-(void)datePickerValueChanged:(UIDatePicker*)datePickerr
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateformatVJ];
    NSString *strDate = [dateFormatter stringFromDate:datePickerr.date];
    
    self.text = strDate;
    
    if (delegateDP)
    {
        if ([delegateDP respondsToSelector:@selector(vjDatePickerValueChanged:withTextField:)])
        {
            NSDateFormatter *send = [[NSDateFormatter alloc] init];
            [send setDateFormat:dateformatVJ2];
            NSString *sendDate = [send stringFromDate:datePickerr.date];
            
            
              [delegateDP vjDatePickerValueChanged:sendDate withTextField:self];
        }
        
      
    }
  
    
}
-(void)numberPaddoneClicked:(id)sender
{
        [self datePickerValueChanged:datePicker];
    [self resignFirstResponder];
    if (delegateDP)
    {
         if ([delegateDP respondsToSelector:@selector(vjDatePickerClickOnDoneBytton:)])
         {
           [delegateDP vjDatePickerClickOnDoneBytton:self];
         }

    }
    
    
}

@end
