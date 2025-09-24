# Clean up the Saga demo application from Kubernetes
# Usage: .\cleanup.ps1

Write-Host "Cleaning up Saga demo application..." -ForegroundColor Green

# Delete ingress
Write-Host "Deleting Ingress..." -ForegroundColor Yellow
kubectl delete -f k8s/ingress.yaml --ignore-not-found=true

# Delete services
Write-Host "Deleting services..." -ForegroundColor Yellow
kubectl delete -f k8s/order-service.yaml --ignore-not-found=true
kubectl delete -f k8s/billing-service.yaml --ignore-not-found=true
kubectl delete -f k8s/inventory-service.yaml --ignore-not-found=true
kubectl delete -f k8s/delivery-service.yaml --ignore-not-found=true

# Delete namespace
Write-Host "Deleting namespace..." -ForegroundColor Yellow
kubectl delete -f k8s/namespace.yaml --ignore-not-found=true

Write-Host "Cleanup completed successfully!" -ForegroundColor Green
