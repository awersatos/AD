
#ifndef __ARCH_LWIP_ERRNO_H__
#define __ARCH_LWIP_ERRNO_H__

//#define  EPERM     1001  /* Operation not permitted */
//#define  ENOENT     1002  /* No such file or directory */
//#define  ESRCH     1003  /* No such process */
//#define  EINTR     1004  /* Interrupted system call */
//#define  EIO     1005  /* I/O error */
#define  ENXIO     1006  /* No such device or address */
#define  E2BIG     1007  /* Arg list too long */
#define  ENOEXEC     1008  /* Exec format error */
//#define  EBADF     1009  /* Bad file number */
#define  ECHILD    1010  /* No child processes */
//#define  EAGAIN    1011  /* Try again */
//#define  ENOMEM    1012  /* Out of memory */
//#define  EACCES    1013  /* Permission denied */
//#define  EFAULT    1014  /* Bad address */
#define  ENOTBLK    1015  /* Block device required */
//#define  EBUSY    1016  /* Device or resource busy */
//#define  EEXIST    1017  /* File exists */
//#define  EXDEV    1018  /* Cross-device link */
//#define  ENODEV    1019  /* No such device */
//#define  ENOTDIR    1020  /* Not a directory */
//#define  EISDIR    1021  /* Is a directory */
//#define  EINVAL    1022  /* Invalid argument */
//#define  ENFILE    1023  /* File table overflow */
//#define  EMFILE    1024  /* Too many open files */
#define  ENOTTY    1025  /* Not a typewriter */
//#define  ETXTBSY    1026  /* Text file busy */
#define  EFBIG    1027  /* File too large */
//#define  ENOSPC    1028  /* No space left on device */
//#define  ESPIPE    1029  /* Illegal seek */
//#define  EROFS    1030  /* Read-only file system */
#define  EMLINK    1031  /* Too many links */
//#define  EPIPE    1032  /* Broken pipe */
//#define  EDOM    1033  /* Math argument out of domain of func */
//#define  ERANGE    1034  /* Math result not representable */
//#define  EDEADLK    1035  /* Resource deadlock would occur */
//#define  ENAMETOOLONG  1036  /* File name too long */
#define  ENOLCK    1037  /* No record locks available */
#define  ENOSYS    1038  /* Function not implemented */
#define  ENOTEMPTY  1039  /* Directory not empty */
//#define  ELOOP    1040  /* Too many symbolic links encountered */
#define  EWOULDBLOCK  EAGAIN  /* Operation would block */
#define  ENOMSG    1042  /* No message of desired type */
#define  EIDRM    1043  /* Identifier removed */
#define  ECHRNG    1044  /* Channel number out of range */
#define  EL2NSYNC  1045  /* Level 2 not synchronized */
#define  EL3HLT    1046  /* Level 3 halted */
#define  EL3RST    1047  /* Level 3 reset */
#define  ELNRNG    1048  /* Link number out of range */
#define  EUNATCH    1049  /* Protocol driver not attached */
#define  ENOCSI    1050  /* No CSI structure available */
#define  EL2HLT    1051  /* Level 2 halted */
#define  EBADE    1052  /* Invalid exchange */
#define  EBADR    1053  /* Invalid request descriptor */
#define  EXFULL    1054  /* Exchange full */
#define  ENOANO    1055  /* No anode */
#define  EBADRQC    1056  /* Invalid request code */
#define  EBADSLT    1057  /* Invalid slot */

#define  EDEADLOCK  EDEADLK

#define  EBFONT    1059  /* Bad font file format */
#define  ENOSTR    1060  /* Device not a stream */
#define  ENODATA    1061  /* No data available */
//#define  ETIME    1062  /* Timer expired */
#define  ENOSR    1063  /* Out of streams resources */
#define  ENONET    1064  /* Machine is not on the network */
#define  ENOPKG    1065  /* Package not installed */
#define  EREMOTE    1066  /* Object is remote */
#define  ENOLINK    1067  /* Link has been severed */
#define  EADV    1068  /* Advertise error */
#define  ESRMNT    1069  /* Srmount error */
#define  ECOMM    1070  /* Communication error on send */
#define  EPROTO    1071  /* Protocol error */
#define  EMULTIHOP  1072  /* Multihop attempted */
#define  EDOTDOT    1073  /* RFS specific error */
#define  EBADMSG    1074  /* Not a data message */
#define  EOVERFLOW  1075  /* Value too large for defined data type */
#define  ENOTUNIQ  1076  /* Name not unique on network */
#define  EBADFD    1077  /* File descriptor in bad state */
#define  EREMCHG    1078  /* Remote address changed */
#define  ELIBACC    1079  /* Can not access a needed shared library */
#define  ELIBBAD    1080  /* Accessing a corrupted shared library */
#define  ELIBSCN    1081  /* .lib section in a.out corrupted */
#define  ELIBMAX    1082  /* Attempting to link in too many shared libraries */
#define  ELIBEXEC  1083  /* Cannot exec a shared library directly */
//#define  EILSEQ    1084  /* Illegal byte sequence */
#define  ERESTART  1085  /* Interrupted system call should be restarted */
#define  ESTRPIPE  1086  /* Streams pipe error */
#define  EUSERS    1087  /* Too many users */
#define  ENOTSOCK  1088  /* Socket operation on non-socket */
#define  EDESTADDRREQ  1089  /* Destination address required */
//#define  EMSGSIZE  1090  /* Message too long */
#define  EPROTOTYPE  1091  /* Protocol wrong type for socket */
#define  ENOPROTOOPT  1092  /* Protocol not available */
#define  EPROTONOSUPPORT  1093  /* Protocol not supported */
#define  ESOCKTNOSUPPORT  1094  /* Socket type not supported */
#define  EOPNOTSUPP  1095  /* Operation not supported on transport endpoint */
#define  EPFNOSUPPORT  1096  /* Protocol family not supported */
#define  EAFNOSUPPORT  1097  /* Address family not supported by protocol */
#define  EADDRINUSE  1098  /* Address already in use */
#define  EADDRNOTAVAIL  1099  /* Cannot assign requested address */
#define  ENETDOWN  1100  /* Network is down */
#define  ENETUNREACH  1101  /* Network is unreachable */
#define  ENETRESET  1102  /* Network dropped connection because of reset */
#define  ECONNABORTED  1103  /* Software caused connection abort */
#define  ECONNRESET  1104  /* Connection reset by peer */
#define  ENOBUFS    1105  /* No buffer space available */
#define  EISCONN    1106  /* Transport endpoint is already connected */
#define  ENOTCONN  1107  /* Transport endpoint is not connected */
//#define  ESHUTDOWN  1108  /* Cannot send after transport endpoint shutdown */
#define  ETOOMANYREFS  1109  /* Too many references: cannot splice */
//#define  ETIMEDOUT  1110  /* Connection timed out */
#define  ECONNREFUSED  1111  /* Connection refused */
#define  EHOSTDOWN  1112  /* Host is down */
#define  EHOSTUNREACH  1113  /* No route to host */
#define  EALREADY  1114  /* Operation already in progress */
//#define  EINPROGRESS  1115  /* Operation now in progress */
#define  ESTALE    1116  /* Stale NFS file handle */
#define  EUCLEAN    1117  /* Structure needs cleaning */
#define  ENOTNAM    1118  /* Not a XENIX named type file */
#define  ENAVAIL    1119  /* No XENIX semaphores available */
#define  EISNAM    1120  /* Is a named type file */
//#define  EREMOTEIO  1121  /* Remote I/O error */
#define  EDQUOT    1122  /* Quota exceeded */

#define  ENOMEDIUM  1123  /* No medium found */
#define  EMEDIUMTYPE  1124  /* Wrong medium type */


#define ENSROK    0 /* DNS server returned answer with no data */
#define ENSRNODATA  1160 /* DNS server returned answer with no data */
#define ENSRFORMERR 1161 /* DNS server claims query was misformatted */
#define ENSRSERVFAIL 1162  /* DNS server returned general failure */
#define ENSRNOTFOUND 1163  /* Domain name not found */
#define ENSRNOTIMP  1164 /* DNS server does not implement requested operation */
#define ENSRREFUSED 1165 /* DNS server refused query */
#define ENSRBADQUERY 1166  /* Misformatted DNS query */
#define ENSRBADNAME 1167 /* Misformatted domain name */
#define ENSRBADFAMILY 1168 /* Unsupported address family */
#define ENSRBADRESP 1169 /* Misformatted DNS reply */
#define ENSRCONNREFUSED 1170 /* Could not contact DNS servers */
#define ENSRTIMEOUT 1171 /* Timeout while contacting DNS servers */
#define ENSROF    1172 /* End of file */
#define ENSRFILE  1173 /* Error reading file */
#define ENSRNOMEM 1714 /* Out of memory */
#define ENSRDESTRUCTION 1175 /* Application terminated lookup */
#define ENSRQUERYDOMAINTOOLONG  1176 /* Domain name is too long */
#define ENSRCNAMELOOP 1177 /* Domain name is too long */

#endif
