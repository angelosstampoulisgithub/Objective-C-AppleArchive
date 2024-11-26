//
//  ViewController.m
//  Objective-C-AppleArchive
//
//  Created by Angelos Staboulis on 26/11/24.
//

#import "ViewController.h"
#import "AppleArchive/AppleArchive.h"
#import <Cocoa/Cocoa.h>
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     


  
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)CmdCompress:(id)sender {
    NSString *dst = [_destinationDirectory stringValue];

   AAByteStream fileStream = AAFileStreamOpenWithPath(dst.UTF8String,
                                                      O_CREAT | O_WRONLY, 0644);

   AAByteStream compressionStream = AACompressionOutputStreamOpen(fileStream,
       AA_COMPRESSION_ALGORITHM_LZFSE, 1<<20, AA_FLAG_VERBOSITY_3, 0);
   AAArchiveStream encodeStream = AAEncodeArchiveOutputStreamOpen(compressionStream,
       NULL, NULL, AA_FLAG_VERBOSITY_3, 0);
  
    NSString *src = [_sourceDirectory stringValue];

   AAPathList pathList = AAPathListCreateWithDirectoryContents(src.UTF8String,
                                                               NULL,
                                                               NULL,
                                                               NULL,
                                                               AA_FLAG_VERBOSITY_3,
                                                               0);
    AAFieldKeySet keySet = AAFieldKeySetCreateWithString(
       "TYP,PAT,LNK,DEV,DAT,UID,GID,MOD,FLG,MTM,BTM,CTM");
    
    int outVal = AAArchiveStreamWritePathList(encodeStream, pathList, keySet,
                                            src.UTF8String, NULL, NULL,
                                             AA_FLAG_VERBOSITY_3, 0);
    outVal = AAArchiveStreamClose(encodeStream);
    AAFieldKeySetDestroy(keySet);
    AAPathListDestroy(pathList);
    outVal = AAByteStreamClose(compressionStream);
    outVal = AAByteStreamClose(fileStream);
}
@end
