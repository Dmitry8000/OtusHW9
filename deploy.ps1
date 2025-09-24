# Script to deploy homework-iden to Kubernetes
Write-Host "Deploying homework-iden to Kubernetes" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Create namespace
Write-Host "`nCreating namespace homework-iden..." -ForegroundColor Yellow
kubectl apply -f k8s/namespace.yaml

# Deploy services
Write-Host "`nDeploying services..." -ForegroundColor Yellow

$services = @(
    "order-service.yaml",
    "billing-service.yaml", 
    "inventory-service.yaml",
    "delivery-service.yaml"
)

foreach ($service in $services) {
    Write-Host "Deploying $service..." -ForegroundColor Cyan
    kubectl apply -f "k8s/$service"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully deployed $service" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to deploy $service" -ForegroundColor Red
    }
}

# Deploy ingress
Write-Host "`nDeploying ingress..." -ForegroundColor Yellow
kubectl apply -f k8s/ingress.yaml
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Successfully deployed ingress" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to deploy ingress" -ForegroundColor Red
}

# Wait for deployments to be ready
Write-Host "`nWaiting for deployments to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=available --timeout=300s deployment/order-service -n homework-iden
kubectl wait --for=condition=available --timeout=300s deployment/billing-service -n homework-iden
kubectl wait --for=condition=available --timeout=300s deployment/inventory-service -n homework-iden
kubectl wait --for=condition=available --timeout=300s deployment/delivery-service -n homework-iden

Write-Host "`n=====================================" -ForegroundColor Cyan
Write-Host "Deployment completed!" -ForegroundColor Green
Write-Host "Services are available at:" -ForegroundColor Cyan
Write-Host "  Order Service: http://arch.homework/order" -ForegroundColor White
Write-Host "  Billing Service: http://arch.homework/billing" -ForegroundColor White
Write-Host "  Inventory Service: http://arch.homework/inventory" -ForegroundColor White
Write-Host "  Delivery Service: http://arch.homework/delivery" -ForegroundColor White
Write-Host "=====================================" -ForegroundColor Cyan
