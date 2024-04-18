@Escribe una función en ensamblador ARM que dado un vector de números naturales devuelva el número almacenado en dicho vector que tenga más “1” en su representación binaria. Tu función se debe llamar maxones y aceptará los siguientes parámetros de entrada: por el registro r0 la dirección del vector y por el registro r1 la longitud de dicho vector. La función devolverá el resultado por el registro r0 y DEBERÁ cumplir el convenio de llamada a funciones.

@Para saber el número de unos de la representación binaria de un número debéis usar la función ones para la que se os proporciona una posible implementación, la cual acepta el número a chequear por el registro r0 y devuelve también por el registro r0 el número de “1” de la representación binaria del valor de entrada.
 
.data
tam:           .word 8
vect:          .word 64,25,9,23,56,77,87,100
res:           .word 0
.text
.global main
main:    push {lr}
         ldr r0, =vect          @ Cargamos direccion del vector en r0
         ldr r1, =tam          
         ldr r1, [r1]           @ Cargamos longitud del vector en r1
         ldr r4, =res           @ Cargamos la direccion de res en r4
         bl maxones             @ Invocamos funcion
         str r0, [r4]           @ Guardamos el resultado en res
         pop {pc}               @ Finalizamos el programa
        
ones:    @Codigo de la funcion que devuelve el numero de 1s en la representación binaria de un valor de entrada.
               mov r2, #0
         onesloop:
               and r3, r0, #1
               add r2, r2, r3
               lsrs r0, #1
               bne onesloop
               mov r0, r2
               bx lr
 
maxones:
   push {r5-r10}
   mov r5,#0 @indice bucle
   mov r6,r0 @copia r0

   ldr r7,[r6,r5] @primer numero
   mov r0,r7
   push {r1,r2,r3,lr}
   bl ones
   pop {r1,r2,r3,lr}
   mov r7,r0 @primer nº de unos
 
 loop:
   cmp r5,r1
   bge exit
   ldr r8,[r6,r5,LSL #2]
   mov r0,r8
   mov r9,r8 @nº que entra en la funcion

   push {r1,r2,r3,lr}
   bl ones
   pop {r1,r2,r3,lr}

   mov r8,r0 @recorremos array y vemos nº de unos
   cmp r7,r8
   movle r7,r8
   movle r10,r9 @movemos el nuevo valor con mas 1 a r10
   add r5,r5,#1
   b loop


   exit:
   mov r0,r10
   pop {r5-r10}
   bx lr

