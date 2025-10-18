package com.alexkisch.levelz_advancements;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.File;

public class LevelZAdvancementsMod implements ModInitializer {
    public static final String MOD_ID = "levelz_advancements";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("[LevelZ Advancements] Mod initializing...");
        ServerLifecycleEvents.SERVER_STARTED.register(server -> {
            LOGGER.info("[LevelZ Advancements] Server started, dumping advancements...");
            File outputFolder = new File("config/levelz_advancements_dump");
            AdvancementDumper.dumpAll(server, outputFolder);
            LOGGER.info("[LevelZ Advancements] Dump complete ✅");
        });
    }
}
