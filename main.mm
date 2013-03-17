#import "CFUserNotification.h"

int main(int argc, char **argv, char **envp) {
  int title_allocated = 0;
  const void *keys[] = {kCFUserNotificationAlertHeaderKey,
                        kCFUserNotificationDefaultButtonTitleKey,
                        kCFUserNotificationAlternateButtonTitleKey,
                        kCFUserNotificationTextFieldTitlesKey
                       };
  const void *values[] = {CFSTR("Please enter your ssh key passphrase"), // default title get's replaced below 
                          CFSTR("Ok"),
                          CFSTR("Cancel"),
                          CFSTR("Passphrase"),
                         };


  if (argc > 1) {
    values[0] = CFStringCreateWithCString(NULL, argv[1], kCFStringEncodingUTF8);
    title_allocated = 1;
  }

  CFDictionaryRef params = CFDictionaryCreate(0, keys, values, sizeof(keys) / sizeof(*keys), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
  SInt32 err = 0;

  CFUserNotificationRef ref;
  ref = CFUserNotificationCreate(kCFAllocatorDefault, 0,
                                 kCFUserNotificationPlainAlertLevel |
                                 //kCFUserNotificationNoDefaultButtonFlag |
                                 CFUserNotificationSecureTextField(0),
                                 &err,
                                 params);

  CFOptionFlags response;
  CFUserNotificationReceiveResponse(ref, 0, &response);

  if ((response & 0x3) == kCFUserNotificationDefaultResponse) {

    CFStringRef str = CFUserNotificationGetResponseValue(ref, kCFUserNotificationTextFieldValuesKey, 0);

    if (title_allocated) CFRelease(values[0]);
    puts([(NSString *)str UTF8String]);
    return 0;
  } else {
    return -1;
  }
}

// vim:ft=objc
