.PHONY: docs
docs:
	rm -rf docs/build/html
	@cd docs && sphinx-apidoc -f -e -o source/ ../python_package/
	@cd docs && make html && make html

.PHONY: doxygen
doxygen:
	rm -rf docs/html
	doxygen Doxyfile

.PHONY: test
test:
	python setup.py test

.PHONY: coverage
coverage:
	coverage run --source python_package setup.py test && coverage html && coverage report
