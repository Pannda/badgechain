api     := ethereum-proxy
profile := ds-badgechain
aws     := aws --profile ${profile}
region  := $(shell ${aws} configure get region)
id      := $(shell ${aws} apigateway get-rest-apis --query 'items[?name==`${api}`].id' --output text)
stages  := $(shell ${aws} apigateway get-stages --rest-api-id ${id} --query 'item[].stageName' --output text)

all:
	@printf "CLI Profile: %s\n" ${profile}
	@printf "AWS Region:  %s\n" ${region}
	@printf "API Name:    %s\n" ${api}
	@printf "API Id:      %s\n" ${id}

export:
	@for i in ${stages}; do \
		${aws} apigateway get-export \
			--rest-api-id ${id} \
			--stage-name $${i} \
			--parameters extensions='integrations' \
			--accepts 'application/json' \
			--export-type swagger \
			${api}-$${i}.yaml; \
		${aws} apigateway get-export \
			--rest-api-id ${id} \
			--stage-name $${i} \
			--parameters extensions='integrations' \
			--accepts 'application/yaml' \
			--export-type swagger \
			${api}-$${i}.yaml; \
	done
