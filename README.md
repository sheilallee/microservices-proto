# microservices-proto

Projeto da disciplina **Programação Distribuída** (Prática - Microsserviços com gRPC).

Este repositório contém:
- arquivos `.proto` (contrato gRPC)
- script de geração de stubs em Go (`run.sh`)
- stubs Go gerados em `golang/order`

## Estrutura

- `order/order.proto`: definição das mensagens e do serviço `Order`
- `run.sh`: instala plugins Go do protobuf e gera código Go
- `golang/order`: stubs Go gerados (`order.pb.go`, `order_grpc.pb.go`)

## Como gerar os stubs (Go)

Pré-requisitos:
- Go instalado
- protoc instalado no sistema
- shell bash (Linux/macOS/Git Bash no Windows)

Na raiz deste repositório:

```bash
sh run.sh
```

## Resultado esperado

Após executar o script, devem existir arquivos em `golang/order`, incluindo:
- `order.pb.go`
- `order_grpc.pb.go`

## Observações

- O arquivo `order.proto` usa o campo `costumer_id` (grafia conforme especificação da prática).
- Este repositório é consumido pelo projeto de serviço em `microservices` via `replace` no `go.mod`.
