# modulox-checkout-proxy

Minimal Railway reverse proxy for Modulo checkout custom domains.

## Purpose

Cloudflare for SaaS custom hostnames cannot terminate directly to the current Render-origin chain without hitting Cloudflare Error 1000. This proxy gives Cloudflare a non-Cloudflare fallback origin while preserving the shopper host in `X-Forwarded-Host`.

## Runtime env vars

- `PORT` (default `8080`)
- `UPSTREAM_URL` (default `https://modulo-api.onrender.com`)
- `UPSTREAM_HOST` (default `modulo-api.onrender.com`)

For production, keep `UPSTREAM_URL` and `UPSTREAM_HOST` aligned.

## Railway setup

1. Import this repo as a new Railway service.
2. Confirm deploy is healthy (`/healthz` returns `ok`).
3. Set custom domain on the Railway service: `checkout.modulox.io`.
4. In Cloudflare DNS, set:
   - `checkout` `CNAME` -> `<your-railway-service>.up.railway.app`
   - Proxy status: `Proxied`
5. In Cloudflare SSL/TLS -> Custom Hostnames, keep fallback origin as `checkout.modulox.io`.
6. Merchant DNS stays:
   - `pay.<merchant-domain>` `CNAME` -> `checkout.modulox.io`

## Notes

- The proxy forces `Host` to `UPSTREAM_HOST` for Render routing.
- The original domain is preserved via `X-Forwarded-Host` for merchant lookup.
