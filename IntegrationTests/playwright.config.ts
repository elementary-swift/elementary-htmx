import { defineConfig, devices } from "@playwright/test";

const port = Number(process.env.INTEGRATION_TESTS_PORT ?? 8484);

export default defineConfig({
  testDir: "./tests",
  forbidOnly: !!process.env.CI,
  retries: 0,
  reporter: process.env.CI ? [["list"], ["html", { open: "never" }]] : "list",
  use: {
    baseURL: `http://127.0.0.1:${port}`,
    trace: "retain-on-failure",
  },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
  // Playwright starts the prebuilt server (see `npm run build:server`) and stops it after the run.
  webServer: {
    command: "swift run --skip-build --package-path Server IntegrationTestServer",
    url: `http://127.0.0.1:${port}/health`,
    env: { PORT: String(port) },
    reuseExistingServer: false,
    timeout: 60_000,
    stdout: "pipe",
    stderr: "pipe",
  },
});
