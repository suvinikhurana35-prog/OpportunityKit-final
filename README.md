# OpportunityKit — Your Potential Has Places to Go.

A responsive, multi-page student opportunity discovery prototype with a premium violet / pink / peach design system and a transparent, rule-based demo matching experience.

## Start locally

```bash
npm install
npm run dev
```

Open the local URL printed by Vite (usually `http://localhost:5173`). Do not open the HTML file from inside the ZIP preview; extract the ZIP first. The app now uses a deferred classic script so the interface can also render when opened directly as a static demo, but API routes require a local server. The complete client-side demo works without provider credentials; profile, saved opportunities, connection requests, organizer plan selections, listing previews, and application tracker entries persist in the current browser using `localStorage`.

For the full-stack API routes, install Vercel CLI (`npm install -g vercel`) and run `vercel dev` from this folder instead of `npm run dev`. Configure the environment variables in `.env.example` in your deployment environment. Do not put server secrets in client code.

## Pages

- `index.html` — launch-style homepage and interactive sample match demo.
- `internships.html` — ranked internship discovery, filters, explanations, save and tracking actions.
- `hackathons.html` — event discovery and preference filters.
- `scholarships.html` — calm funding discovery and official portal references.
- `profile.html` — 3-step student profile wizard.
- `dashboard.html` — saved opportunities, demo tracker, profile completion and next steps.
- `connect.html` — fictional collaborator profiles and simulated connection / project invitations.
- `organizers.html` — organizer onboarding, local listing preview and sample pricing / upgrade simulations.

## Data and transparency

The local catalogue contains exactly 30 entries in each category (90 total). Internship entries are official career-portal discovery links, not confirmed open vacancies; scholarship entries are named schemes with current dates/eligibility requiring confirmation; hackathon entries are public event pages whose current editions must be checked. This is a directory, not a claim that all 90 are open today. Always confirm eligibility, dates, fees, award amounts, and requirements on the official provider page.

- `api/opportunities.js` — up to 30 internship/trainee listings via Adzuna when configured, with public Remotive, Arbeitnow, and The Muse API fallbacks where available.
- `api/catalog.js` — attempts public scholarship / hackathon listing retrieval and returns clearly labelled fallback catalogues when providers block requests.
- `supabase/schema.sql`, `src/`, and `config.example.js` — retained starter assets for a future authenticated backend integration; this visual prototype's current profile persistence is local to the browser.

## Production checklist

Before launch, add secure authentication and server-backed profile persistence, review privacy and consent, test mobile/accessibility flows, verify every external listing and application URL, add moderation for community features, and replace sample organizer prices with approved commercial terms. Organizer plan buttons simulate selection only; no real payments are processed. Sponsored listings should be labeled and must not override eligibility matching.


## Startup troubleshooting

- If you see “Opening your next possibility…” forever, make sure you extracted the ZIP fully and refresh. The HTML pages load `app.js` with `defer` (not as an ES module), avoiding the common `file://` module/CORS failure.
- For the interactive demo, run `npm install` then `npm run dev`.
- If a browser blocks local-file storage, use the local server URL instead.


## Optional AI-assisted opportunity discovery



## No-AI deployment mode (default)

The category pages start with 30 local entries per category (90 total) so filters work even when APIs are unavailable. The frontend does not require OpenAI or Claude keys. The API endpoints can optionally fetch live public data, but live providers may return fewer results and may block server-side requests. No scheduled refresh is configured; verify each official source and update saved entries manually or add a scheduler later.
