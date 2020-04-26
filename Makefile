all: update dhall-freeze dhall-format

update:
	@python3 scripts/update.py

dhall-freeze:
	@dhall --ascii freeze --inplace package.dhall --all

dhall-format:
	@find . -name "*.dhall" -exec dhall --ascii format --inplace {} \;
