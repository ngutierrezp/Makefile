#include <stdio.h>
#include "../include/boards.h"
#include "../include/debug.h"
#include "../include/colors.h"

int main(int argc, char const *argv[])
{
    

    matrix new;
    new.high=10;
    new.width=20;
    new.board[new.high*new.width];

    int i;
    for(i = 0; i < new.high*new.width ; i++)
    {
        new.board[i]='_';
    }

    new.board[10]='X';
    new.board[7]='X';
    new.board[15]='X';
    new.board[0]='X';
    

    #ifdef DEBUG
    print_current(new,5000,5,80,20,9);
    COLOR_TEST;
    #endif

    printf("programa terminado..\n");
    return 0;
}
