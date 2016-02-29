lisp_files := $(wildcard *.el)
lisp_LISP = $(lisp_files)
EXTRA_DIST = $(lisp_files)
MOSTLYCLEANFILES = *.elc

.el.elc:
	if test "$(EMACS)" != "no"; then \
	  am__dir=. am__subdir_includes=''; \
	  case $@ in */*) \
	    am__dir=`echo '$@' | sed 's,/[^/]*$$,,'`; \
	    am__subdir_includes="-L $$am__dir -L $(srcdir)/$$am__dir"; \
	  esac; \
	  test -d "$$am__dir" || $(MKDIR_P) "$$am__dir" || exit 1; \
	  EMACSLOADPATH=$(EMACSLOADPATH) $(EMACS) --batch \
	    $(AM_ELCFLAGS) $(ELCFLAGS) \
	    $$am__subdir_includes -L $(builddir) -L $(srcdir) \
	    --eval "(defun byte-compile-dest-file (f) \"$@\")" \
	    --eval "(unless (byte-compile-file \"$<\") (kill-emacs 1))"; \
	else :; fi

short:
	$(MAKE) 2>&1 >/dev/null | ruby $(top_srcdir)/make-check-filter.rb

%.short:
	$(MAKE) $(@:.short=) 2>&1 >/dev/null