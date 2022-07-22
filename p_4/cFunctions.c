//Gurjinder Singh
//Dinora Blanco
//CMSC313 Project 4
//Spring 2022
//cFunctions.c
//This program is a blend of c and assembly and pain


//c file

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


//create a function that prints all the elemnts of the array
void printArray(char *array[]){
    int i;
    for(i = 0; i < 10; i++){
        printf("Message[%d] = %s", i, array[i]);
        printf("\n");
    }
}
    //this function dynamically allocates more memory based on how long the input is from the user
    char * validate(char * message) {
    int buffer = 256;
    int position = 0;

    char* cmd = malloc(sizeof(char) * buffer);
    
    int cha;
    int cont = 1;
    printf("Enter new message: ");
    while(cont == 1) {
        cha = fgetc(stdin);
        //printf("%c", cha);
        if(cha == EOF || cha == '\n') {
            cmd[position] = '\0';
            cont = 0;
        } else {
            cmd[position] = cha;
        }
        position++;

        if(position >= buffer) {
            buffer += 256;
            cmd = realloc(cmd, buffer);
        }
    }
    return cmd;
}
//create a function that takes an index and a message and puts the message in the array at the index
int putMessage(char *array[], int index){
    //printf("Current index: ");
    //printf("%d", index, "\n");
    //printf("\n");
    //fflush(stdin);
    //printf("Enter new message: ");
    char * temp = validate(array[index]);
    //printf(temp);
    int first = (int)temp[0];
    char last = temp[strlen(temp) - 1]; 
    //Checks for conditions on validity
    if (first > 65 && first < 90) {
        if (last == '.' || last == '?' || last == '!') {
            array[index] = temp;
            return 1;
        } else {
            printf("\nPlease enter a valid message.\n");
            return 0;
        }
    }
    else
    {
        printf("\nPlease enter a valid message.\n");
        return 0;
    }
    //array[index] = validate(array[index]);
    //char * newMessage = validate(message);
}

//sad free function
void freeup (char* message) {
    free(message);
}



//need to make decrypt function