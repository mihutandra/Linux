#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

// Function to check if a number is perfect
int isPerfect(int num) {
    int sum = 1;

    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) {
            sum += i;
            if (i != num / i) {
                sum += num / i;
            }
        }
    }

    return sum == num;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Too few arguments...");
        return 1;
    }

    int N = atoi(argv[1]);

    // Fork multiple child processes
    for (int i = 1; i < N; i++) {
        pid_t pid = fork(); //process is parent or child
        if (pid == -1) {
            perror("fork");
            return 1;
        } else if (pid == 0) { // Child process
            if (isPerfect(i)) {
                printf("%d is perfect\n", i);
            }
            exit(0);
        }
    }

    // Wait for all child processes to complete
    while (wait(NULL) > 0); // until there are no more child processes

    return 0;
}

