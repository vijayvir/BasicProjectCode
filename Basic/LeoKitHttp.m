
//
//  Created by OSX on 06/04/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//


#import "LeoKit.h"

@implementation LeoKitHttp





+(void)sendMultipleImagesWithUserId:(NSString*)user_id school_code:(NSString*)school_code card_name:(NSString*)card_name withFileArray:(NSArray*)arr_fileName  successBlock:(completionBlock)completionBlockService
                       failureBlock:(failureBlock)failureBlockService
{

    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=---011000010111000001101001",
                               @"cache-control": @"no-cache",
                           };
    
    NSArray *parameters = @[ @{ @"name": @"user_id", @"value": user_id },
                                                @{ @"name": @"school_code", @"value": school_code },
                             @{ @"name": @"card_name", @"value": card_name } ];
    NSString *boundary = @"---011000010111000001101001";
    
    NSError *error;
    NSMutableString *body = [NSMutableString string];
  
    for (NSDictionary *param in parameters  )
    
    {
        [body appendFormat:@"--%@\r\n", boundary];
      
        {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
            [body appendFormat:@"%@\r\n", param[@"value"]];
        }
        
    }
     NSMutableData *postData = [[body dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    for (NSString * files in arr_fileName) {
        
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            {
            //[body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", @"upload[]", [files lastPathComponent]];
            
                  [postData appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", @"upload[]", [files lastPathComponent]] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [postData appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"image/jpeg"] dataUsingEncoding:NSUTF8StringEncoding]];
                
         
                [postData appendData:[NSData dataWithContentsOfFile:files]];
                
         [postData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            if (error) {
                NSLog(@"%@", error);
            }
        }
        
    }
   // [body appendFormat:@"\r\n--%@--\r\n", boundary];
     [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error)
        {
            
            
            dispatch_async(dispatch_get_main_queue(),^
                           { failureBlockService(Nil,response,data,error);
                           } );
            
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),^
                           {
            NSDictionary *dict_response = [NSJSONSerialization JSONObjectWithData:
                        data options:NSJSONReadingMutableContainers error:nil];
            if (dict_response)
            {
                
                
                
                completionBlockService(dict_response,response,data,Nil);
                
            }
            else
                {
                dispatch_async(dispatch_get_main_queue(),^
            {
                failureBlockService(Nil,response,data,error);
                
            } );
                               }
                               
                           } );
        }
                                                }];
    [dataTask resume];
}






+(void)sendRequestPost:(NSDictionary*)dict_paran
          successBlock:(completionBlock)completionBlockService
          failureBlock:(failureBlock)failureBlockService
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^
               {
          
    
    
    
    if (LeoMainURL == nil)
        abort();
    

    
    [[Reachability reachabilityForInternetConnection] startNotifier];
    int chk = 0;
    
    NetworkStatus remoteHostStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
        chk = 0;
    
    else if (remoteHostStatus == ReachableViaWiFi)
        chk = 1;
    
    else if (remoteHostStatus == ReachableViaWWAN)
        chk = 1;
    
    if (chk == 0)
    {
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           
             [LeoCallbackAlertView  initWithTitle:LeoProductName message:@"You must be connected to an internet connection via WI-FI or Mobile Connection"
                                   preferredStyle:UIAlertControllerStyleAlert
                                cancelButtonTitle:nil
                             andCompletionHandler:^(NSUInteger index)
                            {
                            } otherButtonTitles:@"OK" , nil];
                           
                           
                           
       failureBlockService(Nil,Nil,Nil,[NSError errorWithDomain:@"Internet connection unavailable." code:700 userInfo:[NSDictionary dictionaryWithObject:@"You must be connected to an internet connection via WI-FI or Mobile Connection" forKey:@"Message"]]);
                       } );
        return;
    }
                   
               
                   NSDictionary *dict=@{@"username": @"Ilena Jennifer DCruz",
                                        @"password":@"James Bond",
                                        @"method":@"signUp",
                                       
                                        };
                   
                   
    NSError *errorw;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict_paran options:0 error:&errorw];
    

    
     NSURLSession *session = [NSURLSession sharedSession];

                   //VijayMainURL
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:LeoMainURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   // [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
  
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
       
        if (error)
        {
      
            
             dispatch_async(dispatch_get_main_queue(),^
                          { failureBlockService(Nil,response,data,error);
                          } );
            
           
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),^
                           {
                    NSDictionary *dict_response = [NSJSONSerialization JSONObjectWithData:
                        data options:NSJSONReadingMutableContainers error:nil];
                               if (dict_response) {
                                   completionBlockService(dict_response,response,data,Nil);
                               }
                               else{
                                   dispatch_async(dispatch_get_main_queue(),^
                                                  { failureBlockService(Nil,response,data,error);
                                                  } );
                               }
                               
                           } );
        }
        
    }];
    
    [postDataTask resume];
    
    
    
         } );
    
    
 
    
}





@end
