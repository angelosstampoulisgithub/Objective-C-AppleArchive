//
//  ViewController.h
//  Objective-C-AppleArchive
//
//  Created by Angelos Staboulis on 26/11/24.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *sourceDirectory;
@property (weak) IBOutlet NSTextField *destinationDirectory;
@property (weak) IBOutlet NSButton *CmdCompress;
- (IBAction)CmdCompress:(id)sender;

@end

