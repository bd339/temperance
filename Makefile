.PHONY: test docs pubdocs test-sbcl test-ccl test-ecl vendor

sourcefiles = $(shell ffind --full-path --literal .lisp)
docfiles = $(shell ls docs/*.markdown)
apidoc = docs/03-reference.markdown

# Testing ---------------------------------------------------------------------
test: test-sbcl test-ccl test-ecl test-abcl

test-sbcl:
	echo; figlet -kf computer 'SBCL' | sed -Ee 's/ +$$//' | tr -s '\n' | lolcat --freq=0.25; echo
	ros run -L sbcl --load test/run.lisp

test-ccl:
	echo; figlet -kf slant 'CCL' | sed -Ee 's/ +$$//' | tr -s '\n' | lolcat --freq=0.25; echo
	ros run -L ccl-bin --load test/run.lisp

test-ecl:
	echo; figlet -kf roman 'ECL' | sed -Ee 's/ +$$//' | tr -s '\n' | lolcat --freq=0.25; echo
	ros run -L ecl --load test/run.lisp

test-abcl:
	echo; figlet -kf broadway 'ABCL' | sed -Ee 's/ +$$//' | tr -s '\n' | lolcat --freq=0.25; echo
	abcl --load test/run.lisp


# Quickutils ------------------------------------------------------------------
vendor: vendor/quickutils.lisp

vendor/quickutils.lisp: vendor/make-quickutils.lisp
	cd vendor && ros run -L sbcl --load make-quickutils.lisp


# Documentation ---------------------------------------------------------------
$(apidoc): $(sourcefiles) docs/api.lisp
	sbcl --noinform --load docs/api.lisp  --eval '(quit)'

docs: docs/build/index.html

docs/build/index.html: $(docfiles) $(apidoc)
	cd docs && ~/.virtualenvs/d/bin/d

pubdocs: docs/build/index.html
	hg -R ~/src/docs.stevelosh.com pull -u
	rsync --delete -a ./docs/build/ ~/src/docs.stevelosh.com/temperance
	hg -R ~/src/docs.stevelosh.com commit -Am 'temperance: Update site.'
	hg -R ~/src/docs.stevelosh.com push
