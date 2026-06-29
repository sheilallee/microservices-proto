# microservices-proto

Projeto da disciplina Programação Distribuída (Prática - Microsserviços com gRPC).
Definições Protobuf e stubs Go gerados para os microsserviços **Order**, **Payment** e **Shipping**.

## Estrutura

```
microservices-proto/
├── order/order.proto         # Definição do serviço Order
├── payment/payment.proto     # Definição do serviço Payment
├── shipping/shipping.proto   # Definição do serviço Shipping
├── golang/
│   ├── order/                # Stubs Go gerados (order.pb.go, order_grpc.pb.go)
│   ├── payment/              # Stubs Go gerados (payment.pb.go, payment_grpc.pb.go)
│   └── shipping/             # Stubs Go gerados (shipping.pb.go, shipping_grpc.pb.go)
├── run.ps1                   # Script de geração (Windows)
└── run.sh                    # Script de geração (Linux/macOS)
```

## Serviços definidos

| Serviço | RPC | Parâmetros principais | Retorno |
|---------|-----|-----------------------|---------|
| Order | `Create` | `costumer_id`, `order_items[]` | `order_id` |
| Payment | `Create` | `user_id`, `order_id`, `total_price` | `payment_id`, `bill_id` |
| Shipping | `Create` | `order_id`, `items[]` | `order_id`, `delivery_days` |

## Como executar

Pré-requisitos:

- Go 1.21+ instalado
- [`protoc`](https://grpc.io/docs/protoc-installation/)

### 1) Gerar stubs — Windows (PowerShell)

```powershell
.\run.ps1 -ServiceName order
.\run.ps1 -ServiceName payment
.\run.ps1 -ServiceName shipping
```

### 2) Gerar stubs — Linux / macOS

```bash
bash run.sh order
bash run.sh payment
bash run.sh shipping
```

O script instala automaticamente os plugins `protoc-gen-go` e `protoc-gen-go-grpc`, gera os arquivos `.pb.go` e `_grpc.pb.go` na pasta `golang/<service>/` e executa `go mod tidy`.

## Resultado esperado

Após rodar o script para cada serviço, os arquivos gerados em `golang/<service>/` são:

```
golang/
├── order/
│   ├── go.mod
│   ├── go.sum
│   ├── order.pb.go
│   └── order_grpc.pb.go
├── payment/
│   ├── go.mod
│   ├── go.sum
│   ├── payment.pb.go
│   └── payment_grpc.pb.go
└── shipping/
    ├── go.mod
    ├── go.sum
    ├── shipping.pb.go
    └── shipping_grpc.pb.go
```

## Uso nos microsserviços

Os stubs são referenciados via `replace` no `go.mod` de cada serviço:

```go
replace github.com/sheilallee/microservices-proto/golang/order    => ../../microservices-proto/golang/order
replace github.com/sheilallee/microservices-proto/golang/payment  => ../../microservices-proto/golang/payment
replace github.com/sheilallee/microservices-proto/golang/shipping => ../../microservices-proto/golang/shipping
```

---

## Licença

Projeto acadêmico — IFPB
