//
//  IBSDWebImagePlugin.m
//  Attributor
//
//  Created by jady on 2017/2/19.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import "IBSDWebImagePlugin.h"
#import <SDWebIMage/SDWebImageManager.h>

@implementation IBSDWebImagePlugin

#pragma mark -ANPluginProtocol

- (void)parseRequest:(ANRequest *)request{

    __weak IBSDWebImagePlugin *weakSelf = self;
    __block ANRequest *blockRequest = request;
    
    request.startBlock = ^(){
        [weakSelf startRequst:blockRequest];
    };
    request.cancelBlock = ^(){
        [weakSelf cancleRequest:blockRequest];
    };
    
}


- (void)startRequst:(ANRequest *)request{

    NSLog(@"start image request");
    NSURL *url = [request parameterForKey:@"key"];
    NSInteger options = [[request parameterForKey:@"options"] integerValue];
    
    if (!url) {
        [request cancel];
        return;
    }
    
    __weak ANRequest *weakRequest = request;
    __weak IBSDWebImagePlugin *weakSelf = self;
    
    SDWebImageDownloaderProgressBlock imageDownloaderProgressBlock = ^(NSInteger receivedSize,NSInteger expecterSize){
        ANRequestProgressBlock progressBlock = weakRequest.progressBlock;
        if (progressBlock) {
            progressBlock(receivedSize,expecterSize);
        }
     };
    
    // 图片完成时，调用项目完成方法
    SDWebImageCompletionWithFinishedBlock imageCompletionBlock = ^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        ANRequestCompletedBlock completedBlock = weakRequest.completedBlock;
        if (completedBlock) {
            // 转化为实际使用的response
            ANResponse *anResponse = [weakSelf parseResponse:image withRequest:request];
            
            // 转化为实际使用的error
            ANError *anError = [weakSelf parseError:error];
            
            // 调用项目完成方法
            completedBlock(weakRequest, anResponse, anError);
        }
    };
    
    // 开始执行SDK请求
    id <SDWebImageOperation> imageOperation =
    [[SDWebImageManager sharedManager] downloadImageWithURL:url
                                                    options:options
                                                   progress:imageDownloaderProgressBlock
                                                  completed:imageCompletionBlock];
    
    [request setParameter:imageOperation forKey:@"image_operation"];
    
}

- (void)cancleRequest:(ANRequest *)request{

    id<SDWebImageOperation> imageOperation = [request parameterForKey:@"image_operation"];
    [imageOperation cancel];
}


#pragma mark parseResponse

- (ANResponse *)parseResponse:(id)sdkResponse withRequest:(ANRequest *)request{


    if (!sdkResponse || ![sdkResponse isKindOfClass:[UIImage class]]) {
        return nil;
    }
    NSDictionary *info = @{@"image":sdkResponse};
    ANResponse *response = [[ANResponse alloc]initWithInfo:info];
    return response;
}

- (ANError *)parseError:(id)sdkError{

    if (!sdkError || [sdkError isKindOfClass:[NSError class]]) {
        return nil;
    }
    NSError *imageError = (NSError *)sdkError;
    ANError *error  = [[ANError alloc]init];
    error.name = imageError.domain;
    error.detail = imageError.description;
    error.code = imageError.code;
    return error;
}

@end
