# Vault configuration POC

## Requirements

1. Azure cli must be installed and configured (`choco install azure-cli` + `az login`)
2. Terraform cli must be install (`choco install terraform`)

## 1. Configure Terraform

This step need to be done only the first time. It will create a service principal for use with Terraform.

### Without service principal

Simply run in a `PowerShell` terminal:

```ps
Terraform\setup.ps1
```

### With Service principal

If the service principal is already created, you need to find his informations and set thoses environment variables:

```text
ARM_SUBSCRIPTION_ID=your_subscription_id
ARM_CLIENT_ID=your_appId
ARM_CLIENT_SECRET=your_password
ARM_TENANT_ID=your_tenant_id
```

## 2. Initialize Terraform

Run in a `PowerShell` terminal:

```ps
terraform init
```

## 3. Optional - Validate the work that Terraform will accomplish

| This will be ask before applying the change anyway so you can pass this step.

Validate that the changes that will be applied will not brake anything.

```ps
terraform plan
```

## 4. Run terraform

```ps
terraform apply
```

## 5. Test
