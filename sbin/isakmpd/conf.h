/* $OpenBSD: conf.h,v 1.31 2005/12/28 10:57:35 hshoexer Exp $	 */
/* $EOM: conf.h,v 1.13 2000/09/18 00:01:47 ho Exp $	 */

/*
 * Copyright (c) 1998, 1999, 2001 Niklas Hallqvist.  All rights reserved.
 * Copyright (c) 2000, 2003 H�kan Olsson.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * This code was written under funding by Ericsson Radio Systems.
 */

#ifndef _CONF_H_
#define _CONF_H_

#include <sys/types.h>
#include <sys/queue.h>
#include <sys/socket.h>
#include <stdio.h>

#define ISAKMPD_ROOT			"/etc/isakmpd/"

#define CONFIG_FILE			ISAKMPD_ROOT "isakmpd.conf"

/* Default values for autogenerated part of our configuration.  */
#define CONF_DFLT_TAG_LIFE_MAIN_MODE   "LIFE_MAIN_MODE"
#define CONF_DFLT_TYPE_LIFE_MAIN_MODE  "SECONDS"
#define CONF_DFLT_VAL_LIFE_MAIN_MODE   "3600,60:86400"

#define CONF_DFLT_TAG_LIFE_QUICK_MODE  "LIFE_QUICK_MODE"
#define CONF_DFLT_TYPE_LIFE_QUICK_MODE "SECONDS"
#define CONF_DFLT_VAL_LIFE_QUICK_MODE  "1200,60:86400"

#define CONF_DFLT_VAL_BLF_KEYLEN       "128,96:192"
#define CONF_DFLT_VAL_AES_KEYLEN       "128,128:256"

#define CONF_DFLT_RETRANSMITS          "3"
#define CONF_DFLT_EXCH_MAX_TIME        "120"

#define CONF_DFLT_USE_KEYNOTE          "yes"
#define CONF_DFLT_POLICY_FILE          ISAKMPD_ROOT "isakmpd.policy"

#define CONF_DFLT_X509_CA_DIR          ISAKMPD_ROOT "ca/"
#define CONF_DFLT_X509_CERT_DIR        ISAKMPD_ROOT "certs/"
#define CONF_DFLT_X509_PRIVATE_KEY     ISAKMPD_ROOT "private/local.key"
#define CONF_DFLT_X509_CRL_DIR         ISAKMPD_ROOT "crls/"
#define CONF_DFLT_PUBKEY_DIR           ISAKMPD_ROOT "pubkeys/"
#define CONF_DFLT_KEYNOTE_CRED_DIR     ISAKMPD_ROOT "keynote/"

#define CONF_DFLT_TAG_PHASE1_CONFIG    "Default-phase-1-configuration"
#define CONF_DFLT_PHASE1_EXCH_TYPE     "ID_PROT"
#define CONF_DFLT_PHASE1_TRANSFORMS    "3DES-SHA-RSA_SIG"

struct conf_list_node {
	TAILQ_ENTRY(conf_list_node) link;
	char	*field;
};

struct conf_list {
	size_t	cnt;
	TAILQ_HEAD(conf_list_fields_head, conf_list_node) fields;
};

extern char    *conf_path;

extern int      conf_begin(void);
extern int      conf_end(int, int);
extern void     conf_free_list(struct conf_list *);
extern struct sockaddr *conf_get_address(char *, char *);
extern struct conf_list *conf_get_list(char *, char *);
extern struct conf_list *conf_get_tag_list(char *);
extern int      conf_get_num(char *, char *, int);
extern char    *conf_get_str(char *, char *);
extern void     conf_init(void);
extern int      conf_match_num(char *, char *, int);
extern void     conf_reinit(void);
extern int      conf_remove(int, char *, char *);
extern int      conf_remove_section(int, char *);
extern int      conf_set(int, char *, char *, char *, int, int);
extern void     conf_report(void);

#endif				/* _CONF_H_ */
