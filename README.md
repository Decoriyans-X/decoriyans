# Decoriyans

**crafted for you**

Handcrafted artisan ecommerce for **web, iOS, and Android** — powered by Flutter.

**Live:** [https://decoriyans.com](https://decoriyans.com)  
**Org:** [https://github.com/Decoriyans-X](https://github.com/Decoriyans-X)

## Stack

| Layer | Technology |
|-------|------------|
| App | Flutter 3 (web + iOS + Android) |
| State | Provider + SharedPreferences |
| Routing | go_router |
| Hosting | AWS S3 + CloudFront |
| DNS | AWS Route 53 (`decoriyans.com`) |
| IaC | Terraform |
| CI/CD | GitHub Actions |

## Features

- Logo-led teal & gold brand theme
- Responsive home, shop, product, cart, checkout
- Unique AI-generated product & hero imagery
- About & Contact (no Artisans page)
- Free shipping threshold and order demo flow

## Local development

```bash
cd app
flutter pub get
flutter run -d chrome          # web
flutter run -d ios             # iOS simulator
flutter run -d android         # Android emulator
```

## Production web build

```bash
cd app
flutter build web --release
# output: app/build/web/
```

## AWS (Route 53 → CloudFront → S3)

```bash
cd infrastructure/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
terraform output nameservers
terraform output s3_bucket_name
terraform output cloudfront_distribution_id
```

Point your domain registrar nameservers to the Route 53 values, then add GitHub Actions secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET_NAME`
- `CLOUDFRONT_DISTRIBUTION_ID`

## Brand

- Primary teal: `#2C4B4F`
- Accent gold: `#A38A58`
- Cream background: `#F7F4EE`
- Logo: `app/assets/brand/logo.png`

## License

Proprietary — © Decoriyans. All rights reserved.
