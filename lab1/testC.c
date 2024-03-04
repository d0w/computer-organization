#include <stdio.h>
// SOLUTION FILE

// EXPLANATIONS ARE WITHIN THE COMMENTS OF THE CODE

main()
{
  int var_int;                    // 2
  unsigned int var_unsigned_int;
	short int var_short_int;
  unsigned short int var_unsigned_short_int;
  long int var_long_int;
  unsigned long int var_unsigned_long_int;
  long long int var_long_long_int;
  unsigned long long int var_unsigned_long_long_int;
  char var_char;
  unsigned char var_unsigned_char;
  signed char var_signed_char;


  unsigned char uchar1, uchar2;   // 3
  signed char schar1, schar2;

  int x, y;                       // 4

  char i;                         // 5
  char shift_char;

  int a[10] = {0,10,20,30,40,50,60,70,80,90};    // 6

  int b[10], c[10];               // 7
  int *ip, *ip2;
  int j, k;

  char AString[] = "HAL";           // 8

  // 1 -- change "World" to your name
  printf("\n\n PART 1 ---------\n");

  printf("\n U18821640 \n");

  // 2 -- find sizes of the other C datatypes
  printf("\n\n PART 2 ----------\n");

  printf("\n size of data type int (implicitly signed) = %d ", sizeof(var_int));
  printf("\n size of data type short int = %d ", sizeof(var_short_int));
  printf("\n size of data type unsigned short int = %d ", sizeof(var_unsigned_short_int));
  printf("\n size of data type unsigned int = %d ", sizeof(var_unsigned_int));
  printf("\n size of data type long int = %d ", sizeof(var_long_int));
  printf("\n size of data type unsigned long int = %d ", sizeof(var_unsigned_long_int));
  printf("\n size of data type long long int  = %d ", sizeof(var_long_long_int));
  printf("\n size of data type unsigned long long int = %d ", sizeof(var_unsigned_long_long_int));
  printf("\n size of data type char = %d ", sizeof(var_char));
  printf("\n size of data type unsigned char = %d ", sizeof(var_unsigned_char));
  printf("\n size of data type signed char = %d ", sizeof(var_signed_char));


  // 3 -- explore signed versus unsigned datatypes and their interactions
  printf("\n\n PART 3 ----------\n");

  uchar1 = 0xFF;
  uchar2 = 0xFE;
  schar1 = 0xFF;
  schar2 = 0xFE;

  printf("\n uchar1 = %d ", uchar1);
  printf("\n schar1 = %d ", schar1);

  /*
  Explanation:
  The unsigned char can hold values from 0-255 so 0xFF is stored as as 255 (int value).
  The signed char can hold values from -128 to 127 due to its signed nature but the same # of bits
  so 0xFF is stored as -1 (int value) since 255 is stored in 2's complement form, creating -1 (b11111111).
  */

  // compare uchar1 and uchar2
  if (uchar1 > uchar2) printf("\n uchar2 is smaller: %d", uchar2);
  else printf("\n uchar1 is smaller: %d", uchar1);

  // compare schar1 and schar2
  if (schar1 > schar2) printf("\n schar2 is smaller: %d", schar2);
  else printf("\n schar1 is smaller: %d", schar1);

  // multiplying mixed
  printf("\n shcar1 * uchar1 = %d", schar1 * uchar1);
  printf("\n --This outputs -255\n");
  // this outputs -255. 

  printf("\n uchar1 * schar2 = %d", uchar1 * schar2);
  printf("\n --This outputs -2\n");
  // this outputs -2. 

  // shcar2 - schar1
  printf("\n schar2 - schar1 = %d", schar2 - schar1);
  // this outputs -1 which is expected -2 -(-1) = -1
  printf("\n --This outputs -1 which is expected -2 -(-1) = -1\n");

  // uchar2 - uchar1
  printf("\n uchar2 - uchar1 = %d", uchar2 - uchar1);
  printf("\n --this outputs -1 which is expected 254 - 255 = -1\n");
  // this outputs -1 which is expected 254 - 255 = -1

  // uchar1 - schar1
  printf("\n uchar1 - schar1 = %d", uchar1 - schar1);
  printf("\n --Prints 256 where the expected value is 256. This is expected\n");
  // Prints 256 where the expected value is 256. This is expected


  // 4 -- Booleans
  printf("\n\n PART 4 ----------\n");

  x = 1; y = 2;

  // printing TRUE and FALSE
  printf("\n True is: %d", x == x);
  printf("\n False is: %d", x == y);

  // size of bool
  printf("\n size of bool is: %d", sizeof(x == x));

  // | and ||
  printf("\n 1 | 2 = %d", x | y);
  printf("\n 1 || 2 = %d", x || y);

  // ~ and !
  printf("\n ~1 = %d", ~x);
  printf("\n !2 = %d", !y);



  // 5 -- shifts
  printf("\n\n PART 5 ----------\n");

  shift_char = 15;
  i = 3;

  printf("\n shift_char << %d = %d", i, shift_char << i);
  printf("\n shift_char >> %d = %d", i, shift_char >> i);

  i = 5;
  printf("\n shift_char >> %d = %d", i, shift_char >> i);
  // this is expected since you are pushing the bits to the right and filling
  // the rest with 0s (since the MSB was 0) so if you shift 15 enough bits, you get 0.
  printf("\n    --this is expected since you are pushing the bits to the right and filling the rest with 0s (since the MSB was 0) so if you shift 15 enough bits, you get 0.\n");


  i = 10;
  printf("\n shift_char >> %d = %d", i, shift_char >> i);
  // same with i = 5, the more you shift, the more you fill with 0s and shift
  // the original bits so you get 0. // Though technically shifting more bits than the size of the data has undefined behavior.
  printf("\n    --Same with i = 5, the more you shift, the more you fill with 0s and shift the original bits so you get 0. Though technically shifting more bits than the size of the data has undefined behavior so this behavior is somewhat unexpected.\n");




  // 6 -- pointer basics
  printf("\n\n PART 6 ----------\n");

  ip = a;
  printf("\nstart %d %d %d %d %d %d %d \n",
	 a[0], *(ip), *(ip+1), *ip++, *ip, *(ip+3), *(ip-1));

   // Some ways this may be incorrect is if the pointer is not initialized or if the pointer is not pointing to the correct data type.
   // Then when incrementing the pointer, it will point to a different address each time as doing arithmetic involves incrementing addresses by the size of the type.


  // 7 -- programming with pointers
  printf("\n\n PART 7 ----------\n");


  // 8 -- strings
  printf("\n\n PART 8 ----------\n");

  printf("\n %s \n", AString);



  // 9 -- address calculation
  printf("\n\n PART 9 ----------\n");
  for (k = 0; k < 10; k++) b[k] = a[k];         // direct reference to array element

  ip = a;
  ip2 = b;
  for (k = 0; k < 10; k++) *ip2++ = *ip++;     // indirect reference to array element

  // all done
  printf("\n\n ALL DONE\n");
}
