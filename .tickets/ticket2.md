## 🪙 Tier & Progression System

### 🎯 Goal
Implement a structured tier system to group advancements and tie them directly to LevelZ skill progression.  
This allows tiered skill unlocks, pending rewards for out-of-order advancement completion, and configurable visibility options.

### 🧩 Tasks
- [ ] Create tier grouping logic for advancements (Tier 1–N).
- [ ] Store metadata: tier number, required advancements, LevelZ skill targets.
- [ ] Implement “pending XP” storage for early unlocks.
- [ ] Add visibility config: hide vs. show locked tiers.
- [ ] Trigger XP gain or unlock when required tier is completed.
- [ ] Add debug logging to verify tier progression logic.

### 🧪 Future Enhancements
- Prestige mode support.
- Custom tier configuration for modpack creators.

### 📌 Dependencies
- Ticket #1 (Advancement Scanner)
- Ticket #3 (Config System)

### 🧠 Notes
- Each advancement belongs to exactly one tier.
- If a player completes higher-tier advancements early, XP should be held until previous tiers are finished.
- Config should control how hidden or visible future tiers are to the player.

