//
//  TimePickerTextField.m
//  Liberty
//
//  Created by OSX on 23/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "TimePickerTextField.h"
#define timeFormatVJ @"hh:mm a"
@implementation TimePickerTextField
{
UIDatePicker *datePicker;

}
@synthesize delegateTP;
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
        datePicker.datePickerMode = UIDatePickerModeTime;
        
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
    [dateFormatter setDateFormat:timeFormatVJ];
    
    
    if (self.text.length>0)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterNoStyle];
        
        NSDate *formatedTime= [formatter dateFromString:self.text];
        
        datePicker.date = formatedTime;
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
        datePicker.datePickerMode = UIDatePickerModeTime;
        
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
    [dateFormatter setDateFormat:timeFormatVJ];
    NSString *strDate = [dateFormatter stringFromDate:datePickerr.date];
    
    self.text = strDate;
    
    if (delegateTP)
    {
        if ([delegateTP respondsToSelector:@selector(vjTimePickerValueChanged:withTextField:)])
        {
        [delegateTP vjTimePickerValueChanged:strDate withTextField:self];
        }
        }
    
    
}
-(void)numberPaddoneClicked:(id)sender
{
    [self datePickerValueChanged:datePicker];
    [self resignFirstResponder];
    if (delegateTP)
    {
        if ([delegateTP respondsToSelector:@selector(vjTimePickerClickOnDoneBytton:)])
        {
        [delegateTP vjTimePickerClickOnDoneBytton:self];
        }
        
        
        
    }
    
    
}@end
