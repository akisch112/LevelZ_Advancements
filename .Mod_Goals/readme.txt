# Advancement Progression Integration Mod

## Overview

This mod integrates advancement-based progression with the skill system from **:contentReference[oaicite:0]{index=0}**.  
It allows players to **unlock and accelerate skill progression through advancements**, giving more structure and meaning to in-game achievements.  

The mod is **client-side only**, meaning it won’t require servers to install it for individual players to benefit from the progression and visibility systems.  

---

## Core Goals

- Tie **advancement completion** directly to **skill point allocation and level caps** in LevelZ.  
- Introduce **dynamic mod support** that automatically pulls in advancements from any mod.  
- Offer flexible configuration for different progression playstyles (strict gating vs. fast-tracking).  
- Create a **scalable, tier-based** advancement structure that supports future prestige systems.  

---

## Feature Breakdown

### 1. **Dynamic Advancement Integration**
- Automatically scans all available advancements, including those added by other mods or datapacks.
- Groups advancements into progression tiers based on difficulty or acquisition order.
- Supports custom grouping through a config file.

### 2. **Skill Point Reward System**
- When a player completes an advancement:
  - If their current skill tier is behind the advancement tier, they get **“catch-up” skill points** automatically.
  - If they’re already at or above that tier, the skill points are stored and applied when they next level up.
- Allows assigning **multiple skills per advancement**.

### 3. **Progression Gating (Configurable)**
Two modes:
- **Strict Gating:** Skills are **capped** at certain levels until specific advancements are completed.  
- **Fast Track:** Players can still level up normally, but **advancements give bonus skill points** to accelerate progression.

### 4. **Tier Unlock Requirements**
- Unlocking a tier requires **completing all advancements in the previous tier**.  
- Players may still **accidentally discover higher-tier advancements**, but they’ll be “banked” until requirements are met.

### 5. **UI/UX**
- To avoid overwhelming players, only **current and previous tier advancements are visible** in the progression UI.
- Future tiers remain hidden until unlocked, giving a sense of mystery and clear goals.

### 6. **Prestige System (Planned)**
- Future update will add a prestige mechanic:
  - Reset skills for additional rewards or multipliers.
  - Tie prestige milestones to completion of entire advancement tiers.

---

## Technical Notes

- Built on **:contentReference[oaicite:1]{index=1}**.
- Uses client-side hooks to track advancement completions and skill state.
- No server installation required.
- Designed to be **mod-agnostic**: supports **:contentReference[oaicite:2]{index=2}** plus any mod that adds advancements.
- Config-driven architecture for scaling.

---

## Example Config Concept (WIP)

```json
{
  "mode": "strict_gating",
  "tiers": {
    "tier1": {
      "advancements": ["minecraft:story/mine_stone", "minecraft:story/upgrade_tools"],
      "skill_rewards": {
        "mining": 5,
        "combat": 2
      }
    },
    "tier2": {
      "advancements": ["minecraft:story/enter_the_nether", "minecraft:story/defeat_wither"],
      "skill_rewards": {
        "mining": 10,
        "combat": 5
      }
    }
  }
}
