package com.alexkisch.levelz_advancements;

import java.util.HashMap;
import java.util.Map;

public class LevelZSkillTreeRegistry {

    // ✅ Define Skill as a static inner class
    public static class Skill {
        private final String id;
        private final String displayName;
        private final int requiredLevel;

        public Skill(String id, String displayName, int requiredLevel) {
            this.id = id;
            this.displayName = displayName;
            this.requiredLevel = requiredLevel;
        }

        public String getId() {
            return id;
        }

        public String getDisplayName() {
            return displayName;
        }

        public int getRequiredLevel() {
            return requiredLevel;
        }
    }

    private static final Map<String, Skill> SKILLS = new HashMap<>();

    public static void initDefaultTree() {
        registerSkill(new Skill("combat_1", "Combat Training I", 5));
        registerSkill(new Skill("combat_2", "Combat Training II", 10));
        registerSkill(new Skill("magic_1", "Basic Magic", 15));
    }

    public static void registerSkill(Skill skill) {
        SKILLS.put(skill.getId(), skill);
    }

    public static Map<String, Skill> getAllSkills() {
        return SKILLS;
    }

    public static Skill getSkill(String id) {
        return SKILLS.get(id);
    }
}
