.PHONY: build
build:
	fastlane build

.PHONY: beta
beta:
	fastlane beta	

.PHONY: testflight
testflight:
	fastlane testflight

.PHONY: prod 
prod:
	fastlane prod

.PHONY: act
act:
	act --container-architecture linux/amd64 -P macos-latest=-self-hosted

.PHONY: auth
auth:
	fastlane spaceauth -u crossguitar@live.jp