/* candl.c */

#include "scheme.h"
#include "scheme-private.h"
#define EXPORT

/* is_number, is_string, is_real,
   ivalue, string_value, rvalue
   mk_integer, mk_string, mk_real  */

pointer foreign_sq(scheme *sc, pointer args) {
  pointer first_arg;
  pointer second_arg;
  float result;
  if(args == sc->NIL)
    return(sc->F);
  
  first_arg = sc->vptr->pair_car(args);
  if(!sc->vptr->is_real(first_arg)) {
    return(sc->F);
  }
  args = sc->vptr->pair_cdr(args);
  second_arg = sc->vptr->pair_car(args);
  if(!sc->vptr->is_real(second_arg)) {
    return(sc->F);
  }
  
  result = sc->vptr->rvalue(first_arg) * sc->vptr->rvalue(second_arg);
  return(sc->vptr->mk_real(sc,result));
}

EXPORT void init_re(scheme *sc) {
  sc->vptr->scheme_define(sc,sc->global_env,sc->vptr->mk_symbol(sc,"sq"),sc->vptr->mk_foreign_func(sc, foreign_sq));
}
