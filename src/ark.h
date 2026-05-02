#ifndef ARK_H
#define ARK_H

#define ARK_VERSION_MAJOR 0
#define ARK_VERSION_MINOR 0
#define ARK_VERSION       "0.0"

#if !(defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 202000L))
#error "Ark requires C23 or later"
#endif

#ifndef ARK_API
#define ARK_API extern
#endif // ARK_API

#ifdef ARK_IMPLEMENTATION
#endif // ARK_IMPLEMENTATION

#ifndef ARK_PREFIXED
#endif // ARK_PREFIXED

#endif // ARK_H
