# Скрипт для запуска Postman тестов Idempotency
Write-Host "=== Running Idempotency Postman Tests ===" -ForegroundColor Cyan

# Проверяем, что newman установлен
try {
    $newmanVersion = newman --version
    Write-Host "Newman version: $newmanVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Newman not found. Please install it with: npm install -g newman" -ForegroundColor Red
    exit 1
}

# Проверяем, что файлы существуют
$collectionFile = "postman/Idempotency_Test_Collection.json"

if (-not (Test-Path $collectionFile)) {
    Write-Host "Error: Collection file not found: $collectionFile" -ForegroundColor Red
    exit 1
}

Write-Host "Collection: $collectionFile" -ForegroundColor Yellow

# Запускаем тесты с отображением данных запроса и ответа
Write-Host "`nRunning Idempotency tests with request/response data display..." -ForegroundColor Yellow

newman run $collectionFile `
    --reporters cli `
    --verbose `
    --disable-unicode `
    --timeout-request 30000

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n=== All Idempotency Tests Passed! ===" -ForegroundColor Green
} else {
    Write-Host "`n=== Some Idempotency Tests Failed! ===" -ForegroundColor Red
    Write-Host "Check the output above for details." -ForegroundColor Yellow
}

Write-Host "`nIdempotency test execution completed." -ForegroundColor Cyan
