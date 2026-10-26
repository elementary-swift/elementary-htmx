import { expect, test, type Page } from "@playwright/test";

// Fail on any htmx or page error, so a broken attribute does not pass silently.
test.beforeEach(async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", (error) => errors.push(error.message));
  page.on("console", (message) => {
    if (message.type() === "error") errors.push(message.text());
  });
  (page as Page & { errors: string[] }).errors = errors;
});

test.afterEach(async ({ page }) => {
  expect((page as Page & { errors: string[] }).errors).toEqual([]);
});

test("loads htmx 4", async ({ page }) => {
  await page.goto("/basic");
  expect(await page.evaluate(() => (window as any).htmx.version)).toBe("4.0.0");
});

test("hx-get with hx-target and hx-swap swaps the response", async ({ page }) => {
  await page.goto("/basic");
  await expect(page.locator("#output")).toHaveClass("original");

  await page.click("#load");

  await expect(page.locator("#output")).toHaveText("Swapped");
  await expect(page.locator("#output")).toHaveClass("swapped");
  // outerHTML replaces the target instead of nesting the response inside it
  await expect(page.locator("#output")).toHaveCount(1);
  await expect(page.locator("#load")).toHaveText("Load");
});

test("hx-config is parsed as HCON and applied to the request", async ({ page }) => {
  await page.goto("/basic");
  await page.click("#configured");

  await expect(page.locator("#config-output")).toHaveText("Swapped");
  const request = JSON.parse((await page.locator("#configured").getAttribute("data-request")) ?? "{}");
  expect(request).toMatchObject({ timeout: "5s", cache: "no-cache", sse: { reconnect: false } });
});

test.describe("explicit inheritance", () => {
  test("hx-target:inherited applies to descendants", async ({ page }) => {
    await page.goto("/inheritance");
    await page.click("#with-button");

    await expect(page.locator("#with-output .fragment")).toHaveText("Fragment");
    await expect(page.locator("#with-button")).toHaveText("With :inherited");
  });

  test("plain hx-target is not inherited", async ({ page }) => {
    await page.goto("/inheritance");
    await page.click("#without-button");

    // without :inherited the button targets itself
    await expect(page.locator("#without-button .fragment")).toHaveText("Fragment");
    await expect(page.locator("#without-output")).toHaveText("empty");
  });

  test("hx-vals:append adds to the inherited value", async ({ page }) => {
    await page.goto("/inheritance");
    await page.click("#append-button");

    await expect(page.locator("#append-output")).toHaveText("tenant=acme source=button");
  });

  test("implicitInheritance from the htmx-config meta tag", async ({ page }) => {
    await page.goto("/inheritance/implicit");
    expect(await page.evaluate(() => (window as any).htmx.config.implicitInheritance)).toBe(true);

    await page.click("#implicit-button");

    await expect(page.locator("#implicit-output .fragment")).toHaveText("Fragment");
  });
});

test("htmx-config meta tag is parsed as HCON", async ({ page }) => {
  await page.goto("/inheritance/implicit");
  const config = await page.evaluate(() => {
    const c = (window as any).htmx.config;
    return {
      implicitInheritance: c.implicitInheritance,
      prefix: c.prefix,
      noSwap: c.noSwap,
      morphIgnore: c.morphIgnore,
      custom: c.custom,
      sseReconnectDelay: c.sse?.reconnectDelay,
      wsReconnectCodes: c.ws?.reconnectCodes,
    };
  });
  expect(config).toEqual({
    implicitInheritance: true,
    prefix: "",
    noSwap: ["204", "304", "4xx"],
    morphIgnore: ["data-htmx-powered", "style"],
    custom: "a b, c",
    sseReconnectDelay: "1s",
    wsReconnectCodes: [1001, 1006],
  });
});

test("<hx-partial> updates multiple targets", async ({ page }) => {
  await page.goto("/partials");
  await page.click("#send");

  await expect(page.locator("#messages p")).toHaveText(["First", "Second"]);
  await expect(page.locator("#count")).toHaveText("2");
  // a response with only partials leaves the main target untouched
  await expect(page.locator("#send")).toHaveText("Send");
  await expect(page.locator("hx-partial")).toHaveCount(0);
});

test.describe("morph swap", () => {
  async function markItems(page: Page, prefix: string) {
    await page.evaluate((prefix) => {
      (document.getElementById(`${prefix}-1`) as any).marker = "kept";
    }, prefix);
  }

  async function marker(page: Page, prefix: string) {
    return page.evaluate((prefix) => (document.getElementById(`${prefix}-1`) as any).marker ?? null, prefix);
  }

  test("innerMorph updates content and keeps existing nodes", async ({ page }) => {
    await page.goto("/morph");
    await markItems(page, "morph");

    await page.click("#morph");

    await expect(page.locator("#morph-list li")).toHaveText(["One (updated)", "Two (updated)", "Three"]);
    expect(await marker(page, "morph")).toBe("kept");
  });

  test("innerHTML replaces nodes (control)", async ({ page }) => {
    await page.goto("/morph");
    await markItems(page, "replace");

    await page.click("#replace");

    await expect(page.locator("#replace-list li")).toHaveText(["One (updated)", "Two (updated)", "Three"]);
    expect(await marker(page, "replace")).toBeNull();
  });
});

test("hx-sse:connect receives a message and hx-sse:close closes", async ({ page }) => {
  await page.goto("/sse");

  await expect(page.locator("#sse-message")).toHaveText("Hello from SSE");
  await expect(page.locator("#sse")).toHaveAttribute("data-closed", "message");
});

test("hx-ws:connect receives messages and hx-ws:send sends", async ({ page }) => {
  await page.goto("/ws");
  await expect(page.locator("#ws-connected")).toHaveText("connected");

  await page.fill("#ws-input", "hello <b>htmx</b>");
  await page.click("#ws-form button");

  await expect(page.locator(".ws-echo")).toHaveText("echo: hello <b>htmx</b>");
  await expect(page.locator("#ws-messages > p")).toHaveCount(2);
});
