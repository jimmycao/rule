.PHONY : clean_pyc new_venv install init test

clean_pyc:
	@find . -name "*.pyc" -exec rm {} +

new_venv:
	@python3.7 -mvenv venv

install:
	@source venv/bin/activate; pip install -e .

init: new_venv
	@source venv/bin/activate; pip install --upgrade pip
	$(MAKE) install

new_venv2:
	@virtualenv venv2

install2:
	@source venv2/bin/activate; pip install -e .

init2: new_venv2
	@source venv2/bin/activate; pip install --upgrade pip
	$(MAKE) install2

test:
	# @python setup.py test
	@python3 -m doctest -v rule/__init__.py

clean:
	@rm -rf dist build

dist: clean
	@source venv/bin/activate; pip install --upgrade setuptools wheel
	@source venv/bin/activate; python3 setup.py sdist bdist_wheel

publish: dist
	@source venv/bin/activate; pip install --upgrade twine
	@source venv/bin/activate; twine upload dist/*

