#include <stdio.h>
#include <lo/lo.h>

int main(){
  lo_address t = lo_address_new("iMac216.local", "60000");
  lo_send(t, "/status", "s", "emergency");
}

lo_address lo_address_new(const char *host, const char *port) {}
int lo_send(lo_address targ, const char *path, const char *type, ...) {}