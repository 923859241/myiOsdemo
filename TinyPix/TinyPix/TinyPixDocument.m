//
//  TinyPixDocument.m
//  TinyPix
//
//  Created by chen on 2021/6/26.
//

#import "TinyPixDocument.h"

@interface TinyPixDocument()

@property(strong, nonatomic) NSMutableData *bitmap;

@end

@implementation TinyPixDocument

-(id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    if (self) {
        unsigned char startPattern[] = {
            0x01,
            0x02,
            0x04,
            0x08,
            0x10,
            0x20,
            0x40,
            0x80
        };
        self.bitmap = [NSMutableData dataWithBytes:startPattern length:8];
    }
    return self;
}

-(BOOL)stateAtRow:(NSUInteger)row colum:(NSUInteger)colum {
    const char *bitmapBytes = [self.bitmap bytes];
    char rowByte = bitmapBytes[row];
    char result = (1 << colum) & rowByte;
    if (result != 0) {
        return YES;
    } else {
        return  NO;
    }
}

-(void)setState:(BOOL)state atRow:(NSUInteger)row colum:(NSUInteger)colum {
    
    char *bitmapByte = [self.bitmap mutableBytes];
    char *rowByte = &bitmapByte[row];
    //由于使用字节码的八个位 每一个代表是否选中 所以这里的 1 << colum 代表从右到左 第colum+1个位置为1。
    //如1 << 2将等于0000 0100
    if (state) {
        *rowByte = *rowByte | (1 << colum);
    } else {
        *rowByte = *rowByte & ~(1<<colum);
    }
}

-(void)toggleStateAtRow:(NSUInteger)row column:(NSInteger)column {
    BOOL state = [self stateAtRow:row colum:column];
    [self setState:!state atRow:row colum:column];
}

-(id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    NSLog(@"saving document to URL %@", self.fileURL);
    return [self.bitmap copy];
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    NSLog(@"loading document from URL %@",self.fileURL);
    self.bitmap = [contents mutableCopy];
    return true;
}

@end
