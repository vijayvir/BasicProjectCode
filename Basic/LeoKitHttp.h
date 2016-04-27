
//  Created by OSX on 06/04/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LeoKitHttp : NSObject<NSURLSessionDelegate>

typedef void (^completionBlock) ( NSDictionary *resultdict,NSURLResponse *response, NSData *data, NSError *error);
typedef void (^failureBlock) ( NSDictionary *resultdict,NSURLResponse *response, NSData *data, NSError *error);



+(void)sendMultipleImagesWithUserId:(NSString*)user_id school_code:(NSString*)school_code card_name:(NSString*)card_name withFileArray:(NSArray*)arr_fileName  successBlock:(completionBlock)completionBlockService
                       failureBlock:(failureBlock)failureBlockService;


+(void)sendMultipleImagesWithUserIde:(NSString*)user_id school_code:(NSString*)school_code card_name:(NSString*)card_name withFileArray:(NSArray*)arr_fileName;


+(void)sendRequestPost:(NSDictionary*)dict
                 successBlock:(completionBlock)completionBlock
                 failureBlock:(failureBlock)failure;
+ (void)sendAsynchronousRequest:(NSURLRequest*)request queue:(NSOperationQueue*)queue completionHandler:(void(^)(NSURLResponse *response, NSData *data, NSError *error))handler;
//+ (void) sendRequestPost: (NSDictionary *) params type:(int) type delegate: (id<responseDelegate>) delegate withTag:(int)tag;


@end
