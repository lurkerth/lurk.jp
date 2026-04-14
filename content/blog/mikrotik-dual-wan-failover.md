---
title: "Dual WAN failover with recursive routing on MikroTik"
date: 2026-04-08
description: "Automatic WAN failover between two ISPs using recursive routing on RouterOS."
tags: ["mikrotik", "networking"]
---

I run two fiber connections at home. Why? Because I got tired of losing connectivity when one ISP decides to take a nap. The fix was obvious — hook both up to a MikroTik and let them sort it out.

The technique is called recursive routing, and once you see it, you'll wonder why anyone does it any other way.

## The problem with the obvious approach

Most people set up two default routes with different distances and `check-gateway=ping`. It works... until your ISP's gateway keeps responding to pings while everything behind it is on fire. PPPoE session up, zero connectivity. The router sits there happily forwarding packets into the void.

Not ideal.

## Recursive routing

The idea is dead simple — don't ping the gateway, ping something on the actual internet.

Pin a public IP to each WAN so each one always takes a specific path:

```
/ip route
add dst-address=8.8.8.8/32 gateway=wan1-interface scope=10 target-scope=10
add dst-address=8.8.4.4/32 gateway=wan2-interface scope=10 target-scope=10
```

The `scope=10` and `target-scope=10` match the scope of connected routes, so these resolve directly through each WAN interface. The default routes below use `target-scope=11`, which lets them resolve recursively through the pinned routes above.

Then use those IPs as gateways for your default routes:

```
/ip route
add dst-address=0.0.0.0/0 gateway=8.8.8.8 distance=1 check-gateway=ping scope=30 target-scope=11
add dst-address=0.0.0.0/0 gateway=8.8.4.4 distance=2 check-gateway=ping scope=30 target-scope=11
```

`distance` is route priority — lower wins. WAN1 gets `distance=1` (primary), WAN2 gets `distance=2` (fallback). RouterOS resolves `8.8.8.8` recursively through the pinned route via WAN1, and `check-gateway=ping` pings that recursive target, not your ISP's gateway — that's the whole point.

If WAN1 loses upstream, the ping to `8.8.8.8` fails, the route gets pulled, and traffic shifts to WAN2 automatically. When WAN1 comes back, so does the route. No intervention needed, no drama.

## Don't trust a single target

Google DNS going down is rare, but rare things happen. I throw in a second set using Quad9 for peace of mind:

```
/ip route
add dst-address=9.9.9.9/32 gateway=wan1-interface scope=10 target-scope=10
add dst-address=149.112.112.112/32 gateway=wan2-interface scope=10 target-scope=10
add dst-address=0.0.0.0/0 gateway=9.9.9.9 distance=1 check-gateway=ping scope=30 target-scope=11
add dst-address=0.0.0.0/0 gateway=149.112.112.112 distance=2 check-gateway=ping scope=30 target-scope=11
```

Now both `8.8.8.8` and `9.9.9.9` need to be unreachable before WAN1 is considered dead. One flaky DNS server won't cause a false failover.

## Bonus: source-based routing

Sometimes you want specific traffic to always leave through a specific WAN. Routing tables and rules make this trivial:

```
/routing table
add name=wan2 fib

/ip route
add dst-address=0.0.0.0/0 gateway=wan2-interface routing-table=wan2

/routing rule
add src-address=192.168.30.0/24 action=lookup-only-in-table table=wan2
```

Everything from that subnet goes out WAN2 no matter what. I use this to keep different types of traffic separated across links.

## Wrapping up

This has been rock solid for me. Failover in seconds, automatic failback, and I genuinely forget it's there — which is exactly how networking should work.

No scripts, no cron jobs, no netwatch hacks. Just routes.

More posts coming soon. Probably about VLANs, WireGuard, or whatever else I feel like writing about. Stay tuned.
