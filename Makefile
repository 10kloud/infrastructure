PYTHON = python3

.DEFAULT_GOAL = run

init:
	@pipenv install --dev
	@mkdir templates || 1

run:
	@${PYTHON} main.py

lint:
	@pipenv run isort .
	@pipenv run black .
	@pipenv run flake8 . --exit-zero

clean:
	@rm -rf ./**/__pycache__
	@rm -rf ./**/.yml
