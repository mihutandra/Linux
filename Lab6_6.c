#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char *argv[]) {
    // Check if the correct number of command-line arguments is provided
    if (argc != 3) {
        printf("not 3 arguments");
        return 1;
    }

    //open file
    FILE *file = fopen(argv[2], "r"); // r- read
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    // open a file for writing
    FILE *temp_file = fopen("temp.txt", "w"); // w- write
    if (temp_file == NULL) {
        perror("Error creating temporary file");
        fclose(file);
        return 1;
    }

    char word[100];
    strcpy(word, argv[1]); // copy the provided word

    char line[100];
    while (fgets(line, sizeof(line), file)) {
        // check if word exists in the current line
        char *found = strstr(line, word);
        if (found != NULL) {
            // ifthe word is found, remove it from the line
            while (found != NULL) {
                memset(found, ' ', strlen(word)); // replace word with spaces
                found = strstr(found + strlen(word), word); // find next occurrence
           	 }
        }
        // write the modified line to the temporary file
        fputs(line, temp_file);
    }

    fclose(file);
    fclose(temp_file);

    if (remove(argv[2]) != 0) {
        perror("Error removing original file");
        return 1;
    }

    if (rename("temp.txt", argv[2]) != 0) {
        perror("Error renaming temporary file");
        return 1;
    }

    printf("Occurrences of '%s' removed from '%s'.\n", word, argv[2]);

    return 0;
}

