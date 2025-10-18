package com.alexkisch.levelz_advancements;

import net.minecraft.server.network.ServerPlayerEntity;
import java.util.Map;

public class PlayerSkillTree {

    public static void applySkills(ServerPlayerEntity player) {
        int levelZ = getPlayerLevel(player);

        // ✅ Notice this — full reference to LevelZSkillTreeRegistry.Skill
        for (Map.Entry<String, LevelZSkillTreeRegistry.Skill> entry : LevelZSkillTreeRegistry.getAllSkills().entrySet()) {
            LevelZSkillTreeRegistry.Skill skill = entry.getValue();

            if (levelZ >= skill.getRequiredLevel()) {
                LevelZAdvancementsMod.LOGGER.info(
                        "Player {} has unlocked skill {}",
                        player.getName().getString(),
                        skill.getDisplayName()
                );
            }
        }
    }

    private static int getPlayerLevel(ServerPlayerEntity player) {
        // Temporary stub
        return 20;
    }
}
