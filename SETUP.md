# OpportunityKit 2.0 — Setup and deployment guide

This is a deployable starter project, not a pre-connected hosted service. You must create your own provider accounts and add credentials for Supabase persistence and AI responses. Live opportunity fetching uses public sources where available; provider access and rate limits may affect results.

## Features in this starter
- Responsive opportunity dashboard and profile fit checker.
- Live internship discovery via Adzuna (optional credentials) and public Remotive, Arbeitnow, and The Muse APIs where available.
- Official scholarship portal cards, linking to government/official sites. These are source links, not a claim that every scheme is currently open.
- Supabase email/password authentication and per-user profile storage with Row Level Security.
- Environment variable templates and Vercel deployment configuration.

## 1. Install and run locally
Prerequisites: Node.js 20+ and npm.

1. Extract the ZIP and open a terminal in this project folder.
2. Install packages:
   ```bash
   npm install
   ```
3. Copy `.env.example` to `.env.local` and set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. Keep `.env.local` out of Git.
4. Start the dev server:
   ```bash
   npm run dev
   ```
5. Open the local URL printed by Vite. The `/api/*` endpoints run on Vercel, not Vite's default server. For full local API testing, deploy to a Vercel preview or add Vercel CLI and run `vercel dev`.

Without configuration, the interface and local fit checker still run. Public listing sources may work without credentials; Supabase login/persistence and AI require configuration.

## 2. Set up Supabase login and database
1. Create a project at https://supabase.com/.
2. In Project Settings → API, copy the project URL and the publishable/anon browser key.
3. Copy `config.example.js` to `config.js`, and paste those two values.
4. Open Supabase → SQL Editor.
5. Paste and run `supabase/schema.sql`.
6. In Authentication → URL Configuration, add your local and deployed app URLs to the allowed redirect/site URL list.
7. In Authentication → Providers, enable Email. Decide whether email confirmation should be enabled for your project.
8. Register a test account in the app, sign in, save a profile, refresh, then use Load saved profile.
9. Check the `profiles` table and confirm a user can only read/update their own row. Row Level Security policies are included in the schema.

Security: the browser may use the publishable/anon key only with RLS enabled. NEVER put a Supabase service-role/secret key in `config.js`, source code, or public repository.

## 3. Activate live internships / jobs
1. Register at https://developer.adzuna.com/ and obtain an `app_id` and `app_key`.
2. Add both as server-side environment variables in Vercel:
   - `ADZUNA_APP_ID`
   - `ADZUNA_APP_KEY`
3. Redeploy. Use the Internships page search field and location selector. If Adzuna credentials are absent or Adzuna is unavailable, the endpoint tries public job-board APIs instead.
4. The API may return general jobs as well as internships, depending on search terms. Search terms like `software intern`, `frontend internship`, or `engineering intern` can help. Verify role, eligibility, location, closing date, and application details on the linked source.

Do not expose Adzuna credentials in browser code. Follow Adzuna API terms, attribution requirements, rate limits, and permitted-use conditions.

## 4. Scholarships
The app includes links to official discovery portals, including India's National Scholarship Portal and AICTE schemes. This starter does not scrape those sites or assert that a particular scheme is open. Portals can change eligibility, dates, and scheme availability. Before adding individual scholarship cards as structured data, use an official data feed/API where available or verify each item manually and record its source and last-checked date. Do not present scraped or stale deadlines as live facts.

1. Obtain an API key from https://platform.openai.com/api-keys.
5. Test English and at least two other languages with eligibility, missing-information, and resume-prep questions.

The AI key is used only by the server endpoint. Never put it in `config.js` or commit it. AI responses may be incorrect; treat them as guidance and verify decisions and deadlines with official sources. Check your provider's pricing, quotas, and data handling before launch.

## 6. Deploy to Vercel
1. Push this project to a private or public GitHub repository. Do not commit `config.js`, API keys, or `.env` files.
2. Sign in at https://vercel.com/ and import the repository.
3. Framework preset: Vite. Build command `npm run build`; output directory `dist`.
5. Deploy.
6. In Supabase Auth URL Configuration, set the deployed Vercel URL as the Site URL and add it to allowed redirect URLs.
7. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` to Vercel environment variables, then redeploy. These are browser-visible values, so use only the publishable/anon key and keep Row Level Security enabled.

## Before public release
- Add rate limiting / abuse controls to the AI endpoint.
- Add privacy policy, data retention rules, and account deletion.
- Validate external URLs and API inputs; monitor API costs and errors.
- Consider CAPTCHA/email verification and password reset UX.
- Confirm API licensing/attribution for job listing display.
- Test accessibility, mobile layout, browser console, and security policies.
- Don't collect sensitive data such as government ID numbers unless absolutely necessary and properly secured.


## Local testing note



## Live opportunity catalogs (up to 30 per category)

- Internships: `/api/opportunities?limit=30` uses Adzuna when `ADZUNA_APP_ID` and `ADZUNA_APP_KEY` are configured. Without credentials or when Adzuna fails, it tries public Remotive, Arbeitnow, and The Muse job-board APIs and filters for internship/trainee wording. Public sources may return fewer than 30 relevant results.
- Scholarships: `/api/catalog?type=scholarships&limit=30` attempts to fetch scheme headings from the official National Scholarship Portal. If that page cannot be fetched or parsed, it uses a clearly labelled curated fallback list.
- Hackathons: `/api/catalog?type=hackathons&limit=30` attempts to fetch public event listings from Devpost and Unstop; if those pages cannot be fetched/parsed, it uses a clearly labelled curated fallback list.
- The endpoints cap responses at 30 per category. The app labels provider/source information and warns users to confirm application windows, eligibility, fees, and event status on the official destination. A successful HTTP fetch does not guarantee that every record is still open or independently verified.
- Generic “search source” cards have been removed. Live entries are preferred; fallback items explicitly tell users to verify current availability, dates, and eligibility.
- For local testing of API endpoints, use `vercel dev` (not only `npm run dev`).

## OpportunityKit premium multi-page prototype

The main demo is now a multi-page responsive client experience: Home, Internships, Hackathons, Scholarships, Connect, For Organizers, Dashboard, and the Student Profile wizard. Run `npm run dev` for the client-only experience. Use `vercel dev` to exercise `/api/*` endpoints locally. Without API credentials, the UI keeps its clearly labeled demo listings; with API access, provider results are displayed with a warning to verify requirements and dates on the official source.

Profile data, saved items, connection requests, tracker status, organizer listing previews, and plan previews currently use browser-local storage for judging convenience. They are not synced across devices or accounts. No real applications, invitations, listings, or payments are submitted.


## Optional AI-assisted opportunity discovery



## No-AI deployment mode (default)

