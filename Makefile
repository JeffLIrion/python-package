.PHONY: docs
docs:
	rm -rf docs/build/html
	@cd docs && sphinx-apidoc -f -e -o source/ ../python_package/
	@cd docs && make html && make html

.PHONY: test
test:
	python setup.py test

.PHONY: doxygen
doxygen:
	rm -rf docs/html
	doxygen Doxyfile
