# 📡 Game Streaming: Network Reference

Wired gaming PC → Wi-Fi clients (Steam Deck OLED, Quest 3, Vision Pro). Use these ranges to read `iperf3` / `ping` results, then confirm against each app's stats overlay once the PC runs.

> ⚠️ No developer publishes tier tables. Tiers below are a synthesis (research agent, Oct 2026) of official docs 🟢, community guides 🟡 and estimates 🔵. Treat boundaries as approximate.

## 🎯 Network tiers (all stacks, measured under load)

| Tier | Ping avg | Ping p99 | Jitter | Loss at stream bitrate |
|---|---|---|---|---|
| 🤩 Amazing | ≤ 2–3 ms | ≤ 6 ms | < 1 ms | 0% |
| 😀 Great | ≤ 5 ms | ≤ 10 ms | ≤ 2 ms | < 0.1% |
| 🙂 Good | ≤ 10 ms | ≤ 20 ms | ≤ 5 ms | < 0.5% |
| 😐 Mediocre | 10–20 ms | spikes > 30 | 5–10 ms | 0.5–2% |
| 😖 Bad | > 20 ms | regular > 50 | > 10 ms | > 2% |

- 💥 **Bursty loss > average loss.** Sunshine adds 20% FEC per frame: scattered drops get fixed, bursts drop whole frames.
- 💤 **Ping idle clients = misleading.** Power-save naps inflate RTT; a stream keeps the radio awake. Always ping *while* iperf3 runs.
- 🥽 **VR:** reprojection hides pipeline latency for head turns; it shows as hand/controller lag + black edges. Jitter/loss hurt most.
- 🎮 **Flat, added latency tolerance 🔵:** competitive < 10–15 ms · action ~20–30 ms · RPG/strategy 50+ ms.

## 🎚️ Bitrates per stack

| Stack | Client | Typical bitrate | Notes |
|---|---|---|---|
| 🥽 Virtual Desktop | Quest 3 | HEVC/AV1 ≤ 200 · H.264+ ≤ 500 🟢 | 400–500 realistically needs 6 GHz @ 160 MHz 🔵. **Not on Vision Pro** (port in progress, no date) 🟡 |
| 🥽 Steam Link VR | Quest 3 | ~100–200, adaptive HEVC 🟡 | Some report stutter > 250 |
| 🎮 Steam Remote Play | Deck | 30–50 HEVC at 800p/90 🟡 | Deck has **no AV1 decode** |
| 🌙 Moonlight + Sunshine | Deck, Vision Pro | 1080p60 20 · 1440p60 40 · 4K60 80 (defaults 🟢) | HDR: +20–30% 🟡, 4K HDR 100–150. Vision Pro (M2): HEVC Main10 HDR works |

**TCP headroom rule 🔵:** sustained TCP ≥ 1.5–2× stream bitrate.

## 📶 Network requirements

- 🟢 PC wired (all three stacks).
- 🟢 Client on 5 GHz minimum; Wi-Fi 6/6E recommended (Valve, Moonlight). 2.4 GHz + powerline = dropped frames.
- 🟡 Router same room / line of sight; clean 80 MHz beats noisy 160 MHz; 6 GHz dedicated to headset if possible.
- ⚠️ Apple clients: periodic stutter → background Wi-Fi scans (AirDrop, Location), per Moonlight FAQ.

## 🧪 App overlays (what to compare later)

- **Virtual Desktop:** per-stage Game / Encode / Network / Decode + total (motion-to-photon since v1.18). Target: Network < 10 ms stable, total 40–50 ms @ 90 Hz 🟡. "Network" ≠ ping (includes frame transfer time).
- **Steam Remote Play:** "Display latency" = capture → display. Deck target < 20 ms; worry > 30 🟡.
- **Moonlight:** network latency ≈ loaded ping; watch "frames dropped by network / jitter". No single end-to-end figure; sum host + network + decode + queue + render.

## 🧰 Test recipe

- 🚀 UDP at stream bitrate, PC/Mac → client, server on client:
  `iperf3 -c <client> -u -b <N>M -t 60` → receiver jitter + loss. Use fixed `-t`: Ctrl-C loses the receiver report.
- 📡 Ping alongside: `ping -i 0.02 -c 3000 <client>` → avg, p99, max.
- 📶 Headroom: `iperf3 -c <client> -t 30` (TCP).
- Levels: 30–50 (flat) · 150–200 (VR HEVC/AV1) · 400–500 (H.264+).

## 📊 Measured: Vision Pro (2 Oct 2026, 5 GHz, router in living room, office one wall away)

| Load | Duration | Ping avg | Worst | Loss | Tier |
|---|---|---|---|---|---|
| 100M UDP | 30 s | 4.0 ms | 9 ms | 0% | 😀 → 🤩 |
| 200M UDP | 60 s | 6.3 ms | 56 ms (1×) | 0.006% | 🙂 → 😀 |
| 380M UDP | 10 s | ~6 steady | 360 ms burst | 1.4% | 😖 (burst) |
| 420M UDP | 10 s | ~5 steady | 280 ms burst | 0.07% | 😖 (burst) |
| TCP max | 30 s | ~70 ms | 189 ms | 0 | ceiling ≈ 458 Mbps |

- ✅ ≤ 200 Mbps stable; Moonlight 4K HDR (100–150) sits in the Great zone.
- ⚠️ Multi-second bursts from ~380 up. 200–380 untested.

## 📊 Measured: Steam Deck OLED (2 Oct 2026, office, router one wall away)

Real-use conditions: held in hands, Wi-Fi power save left **on**. Ping every 20 ms, 15 s runs unless noted.

### 📶 Link: 5 GHz vs 6E (in hands)

| | 5 GHz | 6E |
|---|---|---|
| Width | 80 MHz | 160 MHz |
| Signal | −70 dBm (−64 on table) | −72 dBm |
| Router → Deck link rate | ~306 Mbps, 1 spatial stream | 432–544 Mbps, 2 streams |
| TCP to Deck | 169 Mbps (123–206) · table: 211 | **345 Mbps (~310–444)** |

- 🖐️ Hands cost ~6 dB on 5 GHz → lower modulation, −20% throughput.
- 🚀 6E: weaker signal but 2× throughput (wider channel + both streams).

### 🎮 UDP stream + ping (Mac → Deck)

| Band | Bitrate | Median | p99 | Max | Loss | Verdict |
|---|---|---|---|---|---|---|
| 5 GHz (table, 60 s) | 50M | 4.5 | 24 | 62 | 0 | 🙂 |
| 5 GHz | 70M | 3.3 | 21 | 52 | 0 | 🙂 → 😀 |
| 5 GHz | 100M | 4.7 | 89 | 155 | 0 | ⚠️ 2× ~150 ms bursts |
| **6E** | **100M** | **3.1** | **13** | **28** | **0** | **😀 clean** |
| 6E | 200M | 4.3 | 45 | 98 | 0 | 🎲 2 bursts |
| 6E | 250M | 4.0 | 18 | 31 | 0.013% | 🙂 clean this run |
| 6E | 300M | 5.3 | 95 | 147 | 0.18% | ❌ waves |

- ✅ **6E ≤ 100M: consistently clean.** Covers any Steam stream to the Deck (30–100M).
- 🎲 **200–250M: run-to-run variance > bitrate difference.** Single 15 s runs can't rank them.
- 📉 Failure shape = queue fill/drain (jump → linear decay over ~150 ms), not loss. Appears once bitrate nears the link's weakest seconds.
- 💡 5 GHz handheld: cap ~70M. 6E: room to spare.

## 🔗 Sources

- 🟢 [Moonlight Setup Guide](https://github.com/moonlight-stream/moonlight-docs/wiki/Setup-Guide) · [FAQ](https://github.com/moonlight-stream/moonlight-docs/wiki/Frequently-Asked-Questions) · [bitrate code](https://github.com/moonlight-stream/moonlight-qt/blob/master/app/settings/streamingpreferences.cpp)
- 🟢 [Sunshine configuration](https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2configuration.html)
- 🟢 [Virtual Desktop](https://www.vrdesktop.net/) · [UploadVR: codec ceilings](https://www.uploadvr.com/virtual-desktops-vdxr-runtime/) · [UploadVR: v1.18 overlay](https://www.uploadvr.com/huge-virtual-desktop-update-latency-environments/) · [UploadVR: Vision Pro / VD port](https://www.uploadvr.com/apple-vision-pro-samsung-galaxy-xr-pc-vr-foveated-streaming/)
- 🟡 [VR Discord: Virtual Desktop guide](https://vrdiscord.com/guides/quest-wireless/virtualdesktop.html) · [wireless PCVR guide](https://vrdiscord.com/guides/quest-wireless/index.html)
- 🟡 [Steam Remote Play latency thread](https://steamcommunity.com/groups/homestream/discussions/0/1697168437877152296/)
- [Valve Steam Link for Quest](https://steamcommunity.com/games/593110/announcements/detail/3823053915991825336) · [arXiv 2601.16950: Wi-Fi for VR streaming](https://arxiv.org/html/2601.16950v1)
