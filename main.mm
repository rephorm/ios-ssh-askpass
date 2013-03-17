#import "CFUserNotification.h"

int main(int argc, char **argv, char **envp) {
  const void *keys[] = {kCFUserNotificationAlertHeaderKey,
                        kCFUserNotificationDefaultButtonTitleKey,
                        kCFUserNotificationTextFieldTitlesKey
                       };
  const void *values[] = {CFSTR("Test"),
                          kCFBooleanTrue,
                          CFSTR("Passphrase"),
                         };
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

  CFStringRef str = CFUserNotificationGetResponseValue(ref, kCFUserNotificationTextFieldValuesKey, 0);

  puts([(NSString *)str UTF8String]);
  return 0;
}

// vim:ft=objc
