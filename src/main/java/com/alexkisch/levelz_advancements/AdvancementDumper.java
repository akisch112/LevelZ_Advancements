package com.alexkisch.levelz_advancements;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import net.minecraft.advancement.Advancement;
import net.minecraft.server.MinecraftServer;
import net.minecraft.util.Identifier;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AdvancementDumper {
    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().create();

    public static void dumpAll(MinecraftServer server, File outputFolder) {
        Iterable<Advancement> advancements = server.getAdvancementLoader().getAdvancements();
        Map<String, Object> dump = new HashMap<>();

        for (Advancement advancement : advancements) {
            Identifier id = advancement.getId();
            Map<String, Object> data = new HashMap<>();
            data.put("namespace", id.getNamespace());
            data.put("path", id.getPath());
            if (advancement.getDisplay() != null) {
                data.put("title", advancement.getDisplay().getTitle().getString());
                data.put("description", advancement.getDisplay().getDescription().getString());
            }
            dump.put(id.toString(), data);
        }

        outputFolder.mkdirs();
        File outFile = new File(outputFolder, "levelz_advancements.json");

        try (FileWriter writer = new FileWriter(outFile)) {
            GSON.toJson(dump, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("[LevelZ Advancements] Dumped " + dump.size() + " advancements to " + outFile.getAbsolutePath());
    }
}
