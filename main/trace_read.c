/* SPDX-License-Identifier: GPL-2.0 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../common/common_defines.h"
#include <netinet/ether.h>
#include <arpa/inet.h>

#define TRACEFS_PIPE "/sys/kernel/debug/tracing/trace_pipe"

#ifndef PATH_MAX
#define PATH_MAX	4096
#endif

static void print_ip_addr(const char *key, char *value)
{
	__u32 addr;
	char ip_str[INET_ADDRSTRLEN];

	if (1 != sscanf(value, "%u", &addr))
		return;
	
	inet_ntop(AF_INET, &addr, ip_str, INET_ADDRSTRLEN);
	printf("%s: %s ", key, ip_str);
}

int main(int argc, char **argv)
{
	FILE *stream;
	char *line = NULL;
	size_t len = 0;
	ssize_t nread;
	char action[6];

	stream = fopen(TRACEFS_PIPE, "r");
	if (stream == NULL) {
		perror("fopen");
		exit(EXIT_FAILURE);
	}

	while ((nread = getline(&line, &len, stream)) != -1) {
		char *tok, *saveptr;

		tok = strtok_r(line, " ", &saveptr);

		while (tok) {
			if (!strncmp(tok, "action:", 5)) {
				tok = strtok_r(NULL, ",", &saveptr);
				if (sscanf(tok, "%s", action))
					printf("action: %s ", action);
			}

			if (!strncmp(tok, "src:", 4)) {
				tok = strtok_r(NULL, " ", &saveptr);
				print_ip_addr("src", tok);
			}

			if (!strncmp(tok, "dst:", 4)) {
				tok = strtok_r(NULL, " ", &saveptr);
				print_ip_addr("dst", tok);
			}

			if (!strncmp(tok, "reason:", 6)) {
					printf("reason: %s ", saveptr);
			}

			tok = strtok_r(NULL, " ", &saveptr);
		}

		printf("\n");
	}

	free(line);
	fclose(stream);
	return EXIT_OK;
}
