
<div align="center">

<img src="options/android/icons/icon_mdpi.png" width="150" alt="Nuclear Throne Mobile icon">

<h1>NuclearThroneMobile:Epsilon</h1>

<p>
  <b>Open-source rebuild &amp; Android port of Nuclear Throne (unofficial)</b><br/>
  <sub>Font Pipeline redesign · 60 FPS support · Fix &amp; Improve · Resourcepacks fixed</sub>
</p>


[![License](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](./LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Desktop-3DDC84.svg)](#-building)
[![Engine](https://img.shields.io/badge/Engine-GameMaker-FF7A00.svg)](https://gamemaker.io/)
[![Release](https://img.shields.io/github/v/release/kcd-shichen/NuclearThrone-Recreated-Epsilon?label=Release&color=41AD04.svg)](https://drive.google.com/drive/folders/1f09tGm5UQgpeJRdzlvDUwUycaFQKZUEc?usp=drive_link)
[![Forked](https://img.shields.io/badge/Forked%20From-toarch7/nt%20recreated%20public-yellow.svg)](https://github.com/toarch7/nt-recreated-public)
[![Official_NTM](https://img.shields.io/badge/Original_NTM%20(toarch7)-itch.io-FF2D26.svg)](https://toncho.itch.io/nuclear-throne-mobile/)

</div>

---

## 📖 About

A source-available **rebuild and Android port** of *Nuclear Throne*, the game by [Vlambeer](https://vlambeer.com/). Forked from

<div align="center">
<a href="hhttps://github.com/toarch7/nt-recreated-public">

$$“toarch7/nt-recreated-public"$$

</a>
</div>

Based on a decompiled source of **Update #19 (u19)** and largely rewritten from scratch to match the contents of the latest version.

Built with **GameMaker** — so is the original game.

> [!WARNING]
> **This repository contains no assets from the original game.**
> To make it buildable, you must extract all assets from **your own copy** of Nuclear Throne.
> See [Building](#-building) below.

> [!NOTE]
> This is **not an official build** and is **not affiliated with Vlambeer or the NTM official authors**.
> The original *Nuclear Throne Mobile* by **toncho_** lives at [toncho.itch.io/nuclear-throne-mobile](https://toncho.itch.io/nuclear-throne-mobile/).

---

## ✨ Features

- 🎮 **Play on Android & Desktop** — touch controls out of the box, plus gamepad and keyboard+mouse support
- ⚡ **60 FPS support** — with frame-rate-safe gameplay fixes across weapons, enemies, and effects
- 💾 **Fix & Improve** — built using GM2026.100 or later; making it more stable
- 🌍 **CJK-fonts optimize** — fix the issues  of incomplete font size and cuts; resolve font loading problems
- 🩹 **Font-Pipeline redesign** — all fonts are rendered using direct rendering techniques; this represents a significant improvement in the loading of CJK fonts
- 📦 **Resourcepacks fix** — fix all issues with the original resourcepacks
- 📠 **Command line improvements** — command-line completion features; retention functions; touch optimization
- 🕹️ **Quality-of-life options** — extensive video / control / game settings
- 💰 **Free forever** — no ads, no in-app purchases, no monetization

---

## 📥 Download


> [!CAUTION]
> The releases from this repository **DO NOT** include any physical packages.

- Due to the legal issues, if you want to experience this game, you will need to extract all the assets from your own copy of Nuclear Throne and **build it**. If you find it troublesome, you can try this CLOUD STORAGE button below.
- The cloud storage is where I **store my personal files**; it has **NOTHING** to do with this repository itself. This repo **DOESN'T** come with any assets from the original game.


<div align="center">
<a href="https://drive.google.com/drive/folders/1f09tGm5UQgpeJRdzlvDUwUycaFQKZUEc?usp=drive_link">

<img src="https://img.shields.io/badge/⬇_cloud storage-black?style=for-the-badge" height="34" alt="Download">

</a>
</div>


---

## 🔨 Building

**Requirements**

| Dependency | Notes |
|---|---|
| [GameMaker](https://gamemaker.io/) | IDE (v2026.100+) + runtime (license for Android/Desktop export) |
| [Node.js](https://nodejs.org/) | v20.0+ |
| Nuclear Throne (update 100+) | **your own copy** — assets are extracted from it |

**Resource extraction** — from your own game installation:

```shell
# Windows
.\project-setup-windows.bat

# Linux
bash ./project-setup-linux.sh
```

or manually:

```shell
cd node-scripts
npm ci
npm run regen
```

The scripts extract all assets from your copy of the game and copy them into the GameMaker project, making it compileable.
By default they look in your Steam library; use `-- --game-path="/your/path/here/"` to override.

> [!NOTE]
> Whenever new base-game assets are introduced, run `npm run regen-ignores` — this updates the ignore files so raw assets are never committed.

Then open the project in GameMaker and build for your target platform (Android / Windows / Ubuntu / macOS).

---

## 🖼️ Screenshots

<div align="center">
  <img src="eg/main-menu.png" width="32%" alt="Main menu — Chinese localization">
  <img src="eg/cheats.png" width="32%" alt="Cheat options — framerate anytime">
  <img src="eg/console.png" width="32%" alt="Video settings — 60 FPS option">
</div>

---

## 🙏 Credits

- **[toncho_](https://toncho.itch.io/nuclear-throne-mobile/)** — original *Nuclear Throne Mobile* project
- **[Vlambeer](https://vlambeer.com/)** — *Nuclear Throne*, the game this is built upon
- **All contributors** — see the [contributors](../../graphs/contributors) page

---

## ⚖️ License

This project's code is licensed under the **[GNU General Public License v3.0](./LICENSE)**.

*Nuclear Throne* is created and owned by **Vlambeer**. All rights reserved.
This is a non-commercial fan project and is **not affiliated with or endorsed by Vlambeer**.
No assets from the original game are included in this repository.


<p align="center"><sub>Developed with AI-assisted workflows.</sub></p>
