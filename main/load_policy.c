#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define POLICIES_FILE "policy/policy"

struct policy
{
    int id;
    char ip[20];
    int threshold;
};

struct policy list_policy[10];
int policy_len;

int load_policy()
{
    policy_len = 0;
    int id;
    char ip[20];
    int threshold;

    FILE *fp = fopen(POLICIES_FILE, "r");
    if(fp == NULL)
    {
        printf("[ERROR] Can't open file");
        return -1;
    }
    int err = fscanf(fp, "%d %s %d\n", &id, ip, &threshold);
    if(err >0 )
    {
        printf("Loading policy...\n");
        list_policy[policy_len].id = id;
        strcpy(list_policy[policy_len].ip, ip);
        list_policy[policy_len].threshold = threshold;
        printf("%d\t%s\t%d\n", list_policy[policy_len].id, list_policy[policy_len].ip, list_policy[policy_len].threshold);
        policy_len++;

        while (fscanf(fp, "%d %s %d\n", &id, ip, &threshold) != EOF)
        {
            list_policy[policy_len].id = id;
            strcpy(list_policy[policy_len].ip, ip);
            list_policy[policy_len].threshold = threshold;
            printf("%d\t%s\t%d\n", list_policy[policy_len].id, list_policy[policy_len].ip, list_policy[policy_len].threshold);
            policy_len++;
        }
    }
    fclose(fp);

    return 0;
}