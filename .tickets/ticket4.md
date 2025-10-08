## 🧭 Integration with LevelZ

### 🎯 Goal
Enable direct connection between the Advancement Progression System and LevelZ skill mechanics.  
Advancements should grant XP, enforce caps, and respect config settings.

### 🧩 Tasks
- [ ] Hook into advancement earned events on client.
- [ ] Map advancements to LevelZ skills and XP values.
- [ ] Apply or store XP depending on tier state.
- [ ] Enforce skill caps per tier (read from config).
- [ ] Test with modded advancements for compatibility.
- [ ] Implement multiple-skill rewards per advancement.

### 🧪 Future Enhancements
- Support modded skills and dynamic skill mapping.
- Prestige system integration later.

### 📌 Dependencies
- Ticket #1 (Advancement Scanner)
- Ticket #2 (Tier & Progression System)
- Ticket #3 (Config System)

### 🧠 Notes
- Should be fully client-side for progression logic.
- Pending XP pool allows early advancement rewards to be queued.
- Needs to stay compatible with dynamic mod detection.
- Clean API surface to make future features easy to add.

