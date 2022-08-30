FROM golang:1.18.2-alpine as build

COPY build/app/go.mod src/go.mod
COPY build/app/cmd src/cmd/
COPY build/app/models src/models/
COPY build/app/restapi src/restapi/

RUN cd src/ && go mod tidy

RUN cd src && \
    export CGO_LDFLAGS="-static -w -s" && \
    go build -tags osusergo,netgo -o /application cmd/azure-server/main.go; 

FROM mcr.microsoft.com/azure-cli:2.38.0

RUN mkdir /azextensions
ENV AZURE_EXTENSION_DIR=/azextensions

RUN az config set extension.use_dynamic_install=yes_without_prompt
RUN az config set core.no_color=true
RUN az config set core.only_show_errors=true

RUN az extension add --name ssh
RUN az extension add --name containerapp
RUN az extension add --name k8s-configuration
RUN az extension add --name k8s-extension
RUN az extension add --name k8sconfiguration
RUN az extension add --name connectedk8s
RUN az extension add --name connectedmachine
RUN az extension add --name connectedvmware
RUN az extension add --name aks-preview
RUN az extension add --name application-insights
RUN az extension add --name appservice-kube
RUN az extension add --name automation
RUN az extension add --name azure-batch-cli-extensions
RUN az extension add --name azure-devops
RUN az extension add --name azure-firewall
RUN az extension add --name cloud-service
RUN az extension add --name containerapp-compose
RUN az extension add --name eventgrid
RUN az extension add --name front-door
RUN az extension add --name functionapp
RUN az extension add --name guestconfig
RUN az extension add --name init
RUN az extension add --name notification-hub
RUN az extension add --name peering
RUN az extension add --name serial-console
RUN az extension add --name virtual-network-manager
RUN az extension add --name virtual-network-tap
RUN az extension add --name virtual-wan
RUN az extension add --name vmware
RUN az extension add --name webapp
RUN az extension add --name webpubsub

RUN az extension list

# DON'T CHANGE BELOW 
COPY --from=build /application /bin/application

EXPOSE 8080
EXPOSE 9292

CMD ["/bin/application", "--port=8080", "--host=0.0.0.0", "--write-timeout=0"]