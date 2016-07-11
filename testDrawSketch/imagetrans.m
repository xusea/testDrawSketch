//
//  imagetrans.m
//  testDrawSketch
//
//  Created by xusea on 16/6/1.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "imagetrans.h"
extern void opencvproxy_fillcontour(char * infile, char * outfile);
extern void opencvproxy_imagecut(char * imagein, char * imageout , char *imagelog);
extern double opencvproxy_com2image(char * leftfile, char * rightfile);
@implementation imagetrans
+(void)test
{
    NSLog(@"testtest");
}
+(NSImage *)png2gray:(NSImage *)inimage
{
    //第一步先转黑白
    int width = [inimage size].width;
    int height = [inimage size].height;
    NSBitmapImageRep *repin = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: width
                                 pixelsHigh: height
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: width * 4
                                 bitsPerPixel: 32];
    
    NSGraphicsContext *ctxin = [NSGraphicsContext graphicsContextWithBitmapImageRep: repin];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctxin];
    [inimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctxin flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    unsigned char * rep_bitmapdata = [repin bitmapData];
    NSUInteger rep_bitmapdata_BytesPerRow = [repin bytesPerRow];
    NSColor *fillcolor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0];

    NSColor *tracecolor = [NSColor colorWithCalibratedRed:255.0 green:255.0 blue:255.0 alpha:1.0];

   
    for(int i = 0 ;i< width; i ++)
    {
        for(int j = 0; j< height; j ++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            if( sa < 255.0f * 0.2)
            {
                [repin setColor:fillcolor atX:i y:j];
            }
            else
            {
                [repin setColor:tracecolor atX:i y:j];
            }
        }
    }
    NSData * repdata = [repin representationUsingType:NSPNGFileType properties:nil];
    NSImage * outimage = [[NSImage alloc] initWithData:repdata];
    return outimage;
   //return outimage;
}

+(void)png2file:(NSImage *)inimage outfile:(NSString*)outfile
{
    NSData * repdata = [inimage TIFFRepresentation];
    [repdata writeToFile:outfile atomically:YES];
}

+(void)pngfile2grayfile:(NSString *)infile outfile:(NSString *)outfile
{
    NSImage * inimage = [[NSImage alloc]initWithContentsOfFile:infile];
    if(inimage == nil)
    {
        NSLog(@"cann't open image %@", infile);
        return ;
    }
    NSImage * outimage = [self png2gray:inimage];
    [self png2file:outimage outfile:outfile];
}


+(void)fillcontour:(NSString *)infile outfile:(NSString *)outfile
{
    opencvproxy_fillcontour((char *)[infile UTF8String], (char *)[outfile UTF8String]);
}

+(void)imagecut:(NSString *)infile outfile:(NSString *)outfile logfile:(NSString *)logfile
{
    opencvproxy_imagecut((char *)[infile UTF8String], (char *)[outfile UTF8String] , (char *)[logfile UTF8String]);
}

+(double)imagecom:(NSString *)leftfile rightfile:(NSString *)rightfile
{
    double match = opencvproxy_com2image((char *)[leftfile UTF8String], (char *)[rightfile UTF8String]);
    return match;
}

+(void)imagesketch:(NSString *)grayimage orgimage:(NSString *)orgimage outimage:(NSString *)outimage
{
    NSImage * gimage = [[NSImage alloc]initWithContentsOfFile:grayimage];
    NSImage * oimage = [[NSImage alloc]initWithContentsOfFile:orgimage];
    if(gimage == nil || oimage == nil)
    {
        NSLog(@"imagesketch cann't open file [%@][%@]", grayimage, orgimage);
        return;
    }
    int width = [gimage size].width;
    int height = [gimage size].height;
    NSBitmapImageRep *repgray = [[NSBitmapImageRep alloc]
                               initWithBitmapDataPlanes: NULL
                               pixelsWide: width
                               pixelsHigh: height
                               bitsPerSample: 8
                               samplesPerPixel: 4
                               hasAlpha: YES
                               isPlanar: NO
                               colorSpaceName: NSDeviceRGBColorSpace
                               bytesPerRow: width * 4
                               bitsPerPixel: 32];
    
    NSGraphicsContext *ctxgray = [NSGraphicsContext graphicsContextWithBitmapImageRep: repgray];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctxgray];
    [gimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctxgray flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    unsigned char * gray_bitmapdata = [repgray bitmapData];
    NSUInteger gray_bitmapdata_BytesPerRow = [repgray bytesPerRow];
    
    /////
    NSBitmapImageRep *reporg = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: width
                                 pixelsHigh: height
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: width * 4
                                 bitsPerPixel: 32];
    
    NSGraphicsContext *ctxorg = [NSGraphicsContext graphicsContextWithBitmapImageRep: reporg];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctxorg];
    [oimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctxorg flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    unsigned char * org_bitmapdata = [reporg bitmapData];
    NSUInteger org_bitmapdata_BytesPerRow = [reporg bytesPerRow];
    NSColor *fillcolor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    NSColor *fillcolor2 = [NSColor colorWithCalibratedRed:255.0 green:0.0 blue:0.0 alpha:1.0];
    
/*int left = INT_MAX;
    int right = INT_MIN;
    int top = INT_MIN;
    int buttom = INT_MAX;
    int whiteflag = 0;*/
    for(int i = 0 ;i< width; i ++)
    {
        for(int j = 0; j< height; j ++)
        {
            unsigned char *pixel = gray_bitmapdata + ((i * 4) + (j * gray_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            if( sr < 3 && sg < 3 && sb < 3)
            {
                [reporg setColor:fillcolor atX:i y:j];
            }
            
      /*      else
            {
                if(left > i)
                {
                    left = i;
                }
                if(right < i)
                {
                    right = i;
                }
                if(top < j)
                {
                    top = j;
                }
                if(buttom > j)
                {
                    buttom = j;
                }
                whiteflag = 1;
            }*/
        }
    }
    NSData * repdata = [reporg representationUsingType:NSPNGFileType properties:nil];
    [repdata writeToFile:outimage atomically:YES];
    
    /*if(whiteflag == 1)
    {
        width = right - left;
        height = top - buttom;
        NSRect rect;
        rect.size.width = width;
        rect.size.height = height;
        rect.origin.x = left;
        rect.origin.y = buttom;
        NSBitmapImageRep *repout = [[NSBitmapImageRep alloc]
                                    initWithBitmapDataPlanes: NULL
                                    pixelsWide: width
                                    pixelsHigh: height
                                    bitsPerSample: 8
                                    samplesPerPixel: 4
                                    hasAlpha: YES
                                    isPlanar: NO
                                    colorSpaceName: NSDeviceRGBColorSpace
                                    bytesPerRow: width * 4
                                    bitsPerPixel: 32];
        
        NSGraphicsContext *ctxout = [NSGraphicsContext graphicsContextWithBitmapImageRep: repout];
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext: ctxout];
        [oimage drawAtPoint: NSZeroPoint fromRect: rect operation: NSCompositeCopy fraction: 1.0];
        [ctxout flushGraphics];
        [NSGraphicsContext restoreGraphicsState];
        NSData * outdata = [repout representationUsingType:NSPNGFileType properties:nil];
        NSString * outimagenoalpha = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/sketchnoalpha.png";
        [outdata writeToFile:outimagenoalpha atomically:YES];
        
    }*/
}

+(void)cutalpha:(NSString *)orgimage outimage:(NSString *)outimage
{
    NSImage * oimage = [[NSImage alloc]initWithContentsOfFile:orgimage];
    if(oimage == nil)
    {
        NSLog(@"cutalpah cann't open file %@", orgimage);
        return ;
    }
    int width = [oimage size].width;
    int height = [oimage size].height;

    NSBitmapImageRep *reporg = [[NSBitmapImageRep alloc]
                                initWithBitmapDataPlanes: NULL
                                pixelsWide: width
                                pixelsHigh: height
                                bitsPerSample: 8
                                samplesPerPixel: 4
                                hasAlpha: YES
                                isPlanar: NO
                                colorSpaceName: NSDeviceRGBColorSpace
                                bytesPerRow: width * 4
                                bitsPerPixel: 32];
    
    NSGraphicsContext *ctxorg = [NSGraphicsContext graphicsContextWithBitmapImageRep: reporg];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctxorg];
    [oimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctxorg flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    unsigned char * org_bitmapdata = [reporg bitmapData];
    NSUInteger org_bitmapdata_BytesPerRow = [reporg bytesPerRow];
    NSColor *fillcolor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    int left = INT_MAX;
    int right = INT_MIN;
    int top = INT_MIN;
    int buttom = INT_MAX;
    int alphaflag = 0;
    for(int i = 0 ;i< width; i ++)
    {
        for(int j = 0; j< height; j ++)
        {
            unsigned char *pixel = org_bitmapdata + ((i * 4) + (j * org_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            if( sa > 255.0f * 0.5)
            {
                if(left > i)
                {
                    left = i;
                }
                if(right < i)
                {
                    right = i;
                }
                if(top < j)
                {
                    top = j;
                }
                if(buttom > j)
                {
                    buttom = j;
                }
                alphaflag = 1;
            }
        }
    }
    if(alphaflag == 1)
    {
        width = right - left;
        height = top - buttom;
        NSRect rect;
        rect.size.width = width;
        rect.size.height = height;
        rect.origin.x = left;
        rect.origin.y = buttom-10;
        NSBitmapImageRep *repout = [[NSBitmapImageRep alloc]
                                    initWithBitmapDataPlanes: NULL
                                    pixelsWide: width
                                    pixelsHigh: height
                                    bitsPerSample: 8
                                    samplesPerPixel: 4
                                    hasAlpha: YES
                                    isPlanar: NO
                                    colorSpaceName: NSDeviceRGBColorSpace
                                    bytesPerRow: width * 4
                                    bitsPerPixel: 32];
        
        NSGraphicsContext *ctxout = [NSGraphicsContext graphicsContextWithBitmapImageRep: repout];
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext: ctxout];
        [oimage drawAtPoint: NSZeroPoint fromRect: rect operation: NSCompositeCopy fraction: 1.0];
        [ctxout flushGraphics];
        [NSGraphicsContext restoreGraphicsState];
        NSData * outdata = [repout representationUsingType:NSPNGFileType properties:nil];
        [outdata writeToFile:outimage atomically:YES];
   
    }
    else
    {
        NSLog(@"empty image");
    }

}

+(void)convertDPI72:(NSString *)orgimage outimage:(NSString *)outimage
{
    float dpi = 72.0;
    NSImage * image_dpi = [[NSImage alloc]initByReferencingFile:orgimage];
    if(image_dpi == nil)
    {
        NSLog(@"convertDPI72 cann't open file %@", orgimage);
        return;
    }
    int width = [image_dpi size].width;
    int height = [image_dpi size].height;
    
    if(width < 1 || height < 1)
        return ;
    
    NSBitmapImageRep *rep_dpi = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: width
                                 pixelsHigh: height
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: width * 4
                                 bitsPerPixel: 32];
    
    NSGraphicsContext *ctx_dpi = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_dpi];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_dpi];
    [image_dpi drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_dpi flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    NSSize pointsSize = rep_dpi.size;
    NSSize pixelSize = NSMakeSize(rep_dpi.pixelsWide, rep_dpi.pixelsHigh);
    
    CGFloat currentDPI = ceilf((72.0f * pixelSize.width)/pointsSize.width);
    NSLog(@"current DPI %f", currentDPI);
    
    NSSize updatedPointsSize = pointsSize;
    
    updatedPointsSize.width = ceilf((72.0f * pixelSize.width)/dpi);
    updatedPointsSize.height = ceilf((72.0f * pixelSize.height)/dpi);
    
    [rep_dpi setSize:updatedPointsSize];
    
    NSData *data = [rep_dpi representationUsingType: NSPNGFileType properties: nil];
    [data writeToFile: outimage atomically: YES];
}
+(void)resizeimage:(NSString *)orgimage outimage:(NSString *)outimage newsize:(NSSize)ns
{
    NSImage * image_dpi = [[NSImage alloc]initByReferencingFile:orgimage];
    if(image_dpi == nil)
    {
        NSLog(@"resizeimage cann't open file %@", orgimage);
        return ;
    }
    float width = [image_dpi size].width;
    float height = [image_dpi size].height;
    float rations = ns.height / ns.width;
    float ratioorg = (float)height / (float)width;
    float ratio = 0.0;
    if(rations > ratioorg)
    {
        ratio = width / ns.width;
    }
    else
    {
        ratio = height / ns.height;
    }
    width /= ratio;
    height /= ratio;
    if(width < 1 || height < 1)
        return ;
    
    NSBitmapImageRep *rep_dpi = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: width
                                 pixelsHigh: height
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: width * 4
                                 bitsPerPixel: 32];
    
    NSGraphicsContext *ctx_dpi = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_dpi];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_dpi];
    [image_dpi drawInRect:NSMakeRect(0, 0, width, height) fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    //[image_dpi drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_dpi flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    NSData *data = [rep_dpi representationUsingType: NSPNGFileType properties: nil];
    [data writeToFile: outimage atomically: YES];
}
@end
