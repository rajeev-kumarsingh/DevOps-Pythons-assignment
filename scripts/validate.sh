#Validate Server
# curl http://localhost:5000
#!/bin/bash
# Validate server is running
url="http://localhost:80"
max_retries=10  # Number of times to check
sleep_interval=5  # Time (in seconds) between checks
retry_count=0
success_status_for_HTTP_requests=200   # 200 OK: Standard success status for HTTP requests.

echo "Validating application at $url..."

while [ $retry_count -lt $max_retries ]; do
  response=$(curl --write-out "%{http_code}" --silent --output /dev/null $url)
  if [ "$response" -eq "success_status_for_HTTP_requests" ]; then
    echo "Validation successful: Application is running and reachable at $url"
    exit 0
  else
    echo "Validation failed: HTTP response code $response. Retrying in $sleep_interval seconds..."
    ((retry_count++))
    sleep $sleep_interval
  fi
done
