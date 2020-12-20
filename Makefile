all: update dhall-format

update:
	@python3 scripts/update.py

dhall-format:
	@find . -name "*.dhall" -exec dhall --ascii format --inplace {} \;
