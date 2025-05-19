</$objtype/mkfile

HFILES=\
	config.h\
	pcre2.h\

OFILES=\
	pcre2grep.$O\
	pcre2_compile.$O\
	pcre2_match.$O\
	pcre2_match_data.$O\
	pcre2_error.$O\
	pcre2_config.$O\
	pcre2_context.$O\
	pcre2_maketables.$O\
	pcre2_string_utils.$O\
	pcre2_newline.$O\
	pcre2_compile_cgroup.$O\
	pcre2_compile_class.$O\
	pcre2_chkdint.$O\
	pcre2_valid_utf.$O\
	pcre2_find_bracket.$O\
	pcre2_auto_possess.$O\
	pcre2_study.$O\
	pcre2_script_run.$O\
	pcre2_tables.$O\
	pcre2_ucd.$O\
	pcre2_chartables.$O\

default:V: $O.pcre2grep

PCRESRC=deps/pcre2

CLEANFILES=\
	$PCRESRC/src/pcre2_chartables.c\

CC=pcc
LD=pcc

CFLAGS=-c -I. -I$PCRESRC/src -DHAVE_CONFIG_H -DPCRE2_CODE_UNIT_WIDTH=8
CFLAGS=$CFLAGS -D__${objtype}__

deps:
	mkdir -p deps

$PCRESRC: deps
	test -d $PCRESRC || git/clone https://github.com/PCRE2Project/pcre2 $PCRESRC

$PCRESRC/%:Q: $PCRESRC
	test -e $target

$PCRESRC/src/pcre2_chartables.c: $PCRESRC/src/pcre2_chartables.c.dist
	cp $prereq $target

%.$O: $PCRESRC/src/%.c
	$CC $CFLAGS -o $stem.$O $PCRESRC/src/$stem.c

$O.pcre2grep: $OFILES
	$LD -o $target $prereq

install-pcre2grep-bin:V: /$objtype/bin/pcre2grep

/$objtype/bin/pcre2grep: $O.pcre2grep
	cp $prereq $target

install-pcre2grep-man:V: /sys/man/1/pcre2grep

/sys/man/1/pcre2grep: $PCRESRC/doc/pcre2grep.1
	cp $prereq $target

install-pcre2grep:V: install-pcre2grep-bin install-pcre2grep-man

install:V: install-pcre2grep

clean:V:
	rm -rf [$OS].* *.[$OS] $CLEANFILES

uninstall:V:
	rm -f /$objtype/bin/pcre2grep /sys/man/1/pcre2grep

nuke:V: clean uninstall
