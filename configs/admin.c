/*************************************************************************

 Admin page for wEMBOSS docker
 Author Rafael Hernandez <https://github.com/fikipollo>

*************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <sys/types.h>
#include <errno.h>
#define NOBODY "wemboss"
char *user;
int  userid;

void print_error( char *error_context, char *error_message) {
 int cl;
  printf("Content-type: text/html\n\n");
  printf("error, %s <P>", error_context);
    printf("%s", error_message);
  exit(1);
}

main(int argc, char *argv[]) {

      if (getuid() !=  getpwnam(NOBODY)->pw_uid) {
            print_error("catch:", "Sorry, the owner of this process is not allowed to run admin program, ask server manager! ");
      }

      /*  Identifying the user, he becomes the owner of the process */

      fflush(NULL);
      execv ("./admin.pl", argv, NULL);
      print_error("catch: can't execute admin.pl", "admin.pl");
} /* main */
