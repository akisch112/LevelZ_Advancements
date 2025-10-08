## ⚙️ Config System for Advancement–LevelZ Integration

### 🎯 Goal
Implement a flexible configuration system that controls how advancements affect LevelZ progression.  
This gives modpack authors and players full control over progression pacing and rules.

### 🧩 Tasks
- [ ] Define JSON5/TOML schema for:
  - Progression mode (strict / hybrid / off)
  - Skill caps per tier
  - XP per advancement
  - Tier visibility
- [ ] Implement config loader & validator.
- [ ] Add hooks in progression system to read config values.
- [ ] Optional: hot-reload support for devs.
- [ ] Expose config structure in README for modpack creators.

### 🧪 Future Enhancements
- Server sync support (optional).
- GUI editor for config.

### 📌 Dependencies
- Ticket #2 (Tier & Progression System)

### 🧠 Notes
- “Strict mode” = Advancements required to unlock skills.
- “Hybrid mode” = Advancements grant bonus XP but don’t block leveling.
- Allow per-skill overrides and XP scaling.
- Should be compatible with future prestige systems.

