TARGETS=all check clean clobber distclean install uninstall
TARGET=all

PREFIX=${DESTDIR}/opt
BINDIR=${PREFIX}/bin
SUBDIRS=

ifeq	(${MAKE},gmake)
	INSTALL=ginstall
else
	INSTALL=install
endif
LN	= /bin/ln

.PHONY: ${TARGETS} ${SUBDIRS}

all::	add-remote.zsh

${TARGETS}::

clobber distclean:: clean

check::	add-remote.zsh
	./add-remote.zsh ${ARGS}

install:: add-remote.zsh
	${DEBUG} ${INSTALL} -D add-remote.zsh ${BINDIR}/add-remote

install::
	cd ${BINDIR}; for pseudo in local github; do			\
		${DEBUG} ${LN} -sfv ./add-remote add-$${pseudo};	\
	done

uninstall::
	${RM} ${BINDIR}/add-remote

ifneq	(,${SUBDIRS})
${TARGETS}::
	${MAKE} TARGET=$@ ${SUBDIRS}
${SUBDIRS}::
	${MAKE} -C $@ ${TARGET}
endif
