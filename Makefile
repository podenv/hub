all: dhall-freeze dhall-format

dhall-freeze:
	@dhall --ascii freeze --inplace package.dhall --all

dhall-format:
	@find . -name "*.dhall" -exec dhall --ascii format --inplace {} \;
