#include <stdio.h>
#include <stdlib.h>

// #define UNIQUE_BLOCK_SIZE 4
#define UNIQUE_BLOCK_SIZE 14

char *read_line(FILE *fp)
{
    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    read = getline(&line, &len, fp);
    if (read == -1)
        return NULL;
    return line;
}

int main()
{
    FILE *fp;
    char *line = NULL;
    fp = fopen("input.txt", "r");
    line = read_line(fp);

    int i = 0;
    int *map = malloc(26 * sizeof(int));

    while (line[i + UNIQUE_BLOCK_SIZE - 1] != '\0')
    {
        // declare a boolean flag for a unique block
        int uniqueBlock = 0;
        for (int j = 0; j < UNIQUE_BLOCK_SIZE; j++)
        {
            int charToIndex = line[i+j] - 'a';
            if (map[charToIndex] == 0) map[charToIndex] = 1;
            else break;
            if (j == UNIQUE_BLOCK_SIZE - 1) uniqueBlock = 1;
        }
        // if we managed to get through four unique characters, we have a result
        if (uniqueBlock == 1) break;

        // otherwise clear the map
         for (int j = 0; j < UNIQUE_BLOCK_SIZE; j++) {
            int charToIndex = line[i+j] - 'a';
            map[charToIndex] = 0;
         }
        // and increment the counter
        i++;
    }

    // print the value of i
    printf("Start of packet marker: %d \n",i + UNIQUE_BLOCK_SIZE);
}



