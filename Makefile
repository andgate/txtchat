all: client server deploy


server: setup-server build-server
client: setup-client build-client


setup: setup-client setup-server

build: build-client build-server



setup-client:
	(cd backend ; stack docker pull ; stack setup)

build-client:
	(cd frontend ; stack build --install-ghc ; stack install --local-bin-path ../app)


setup-server:
	(cd backend ; stack docker pull ; stack setup)

build-server:
	(cd backend ; stack build ; stack install --local-bin-path ../bin)
	upx --best --ultra-brute ./bin/txtchat


deploy:
	docker login
	$(aws ecr get-login --no-include-email)
	docker build --rm -t txtchat .
	docker tag txtchat:latest 305551978151.dkr.ecr.us-east-2.amazonaws.com/txtchat:latest
	docker push 305551978151.dkr.ecr.us-east-2.amazonaws.com/txtchat:latest
