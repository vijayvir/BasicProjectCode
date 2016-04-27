//
//  TableViewTextField.m
//  Kwipshare
//
//  Created by iOS Developer on 23/04/16.
//  Copyright © 2016 Hocrox. All rights reserved.
//

#import "TableViewTextField.h"

@implementation TableViewTextField
{
    NSArray * arrOfObjects;
    UIPickerView *datePicker;
    
}
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardwillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:self];
        
        
        datePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        [datePicker selectRow:1 inComponent:0 animated:YES];

        datePicker.delegate = self;
        datePicker.dataSource = self;
        
        datePicker.showsSelectionIndicator=YES;
        self.inputView = datePicker;
    }
    
    
    
    return self;
}

-(void)keyboardwillHide:(NSNotification *)notification
{
    // Save the height of keyboard and animation duration
    NSDictionary *userInfo = [notification userInfo];
    
    
    if (self.delegateTV)
    {
        [self numberPaddoneClicked:self];
        
        
        if ( [self.delegateTV respondsToSelector:@selector(vjTableViewTextFieldKeyboardWillhide:)]) {
           [self.delegateTV vjTableViewTextFieldKeyboardWillhide:self];
           
            
            
            
        }
    }
}

-(void)keyboardWillShow
{
    // Animate the current view out of the way
    
    if (self.delegateTV)
    {
       
        if ( [self.delegateTV respondsToSelector:@selector(vjTableViewTextFieldKeyboardWillshow:)]) {
            arrOfObjects = [self.delegateTV vjTableViewTextFieldKeyboardWillshow:self];
            [datePicker reloadAllComponents];
            
            
            
        }
    }
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrOfObjects.count ;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.delegateTV)
    {
        
        if ( [self.delegateTV respondsToSelector:@selector(vjTableViewTextField:withObject:)])
        {
             return  [self.delegateTV vjTableViewTextField:self withObject:[arrOfObjects objectAtIndex:row]];
            
     
            
        }
    }
    
    return @"";
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ( [self.delegateTV respondsToSelector:@selector(vjTableViewTextField:withObject:)])
    {
        self.text = [self.delegateTV vjTableViewTextField:self withObject:[arrOfObjects objectAtIndex:row]];
        
        
        
    }
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
    
    [self resignFirstResponder];
    
    if (![datePicker selectedRowInComponent:0])
    {
         [datePicker selectRow:0 inComponent:0 animated:YES];
        
        [self pickerView:datePicker didSelectRow:0 inComponent:0];
        
    }

    if ( [self.delegateTV respondsToSelector:@selector(vjTextFieldEnterDone:withObject:)])
    {
        [self.delegateTV vjTextFieldEnterDone:sender withObject:[arrOfObjects objectAtIndex:[datePicker selectedRowInComponent:0]]];
        
    }
    
}

@end
