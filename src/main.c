/*
 *  main.cpp
 *
 *  Hello World for Nintendo DS consoles
 *
 *  Created by Nicola Lamacchia, 2020
 *
 */

#include <nds.h>
#include <stdio.h>

int main()
{
    consoleDemoInit();

    // Move the cursor to row 11 and column 9 and then print "Hello World"
    printf("\x1b[12;10HHello World");

    // Prevent Nintendo DS doesn't reboot upon program completion
    for (;;)
        ;

    return 0;
}
