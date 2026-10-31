#!/usr/bin/env bash
# Runs the ElementaryHTMX4 integration tests: builds the test server, starts it,
# runs Playwright against real htmx 4 in headless Chromium, then stops the server.
set -euo pipefail

cd "$(dirname "$0")"

npm ci
if [ -n "${CI:-}" ]; then
    npx playwright install --with-deps chromium
else
    npx playwright install chromium
fi
npm test -- "$@"
