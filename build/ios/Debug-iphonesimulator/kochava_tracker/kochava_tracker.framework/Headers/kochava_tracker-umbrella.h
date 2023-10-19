#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KochavaTrackerPlugin.h"

FOUNDATION_EXPORT double kochava_trackerVersionNumber;
FOUNDATION_EXPORT const unsigned char kochava_trackerVersionString[];

