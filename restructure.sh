#!/bin/zsh
# --- Restructure LevelZ Advancements Mod Folder ---

echo "📦 Starting cleanup and restructuring..."

# 1. Ensure target directories exist
mkdir -p src/main/java/com/alexkisch/levelz_advancements/mixin
mkdir -p src/main/resources/assets/levelz_advancements/textures/gui

# 2. Move mod config files if they exist
if [ -f "fabric.mod.json" ]; then
  mv fabric.mod.json src/main/resources/
fi
if [ -f "levelz_advancements.mixins.json" ]; then
  mv levelz_advancements.mixins.json src/main/resources/
fi
if [ -f "levelz_advancements.client.mixins.json" ]; then
  mv levelz_advancements.client.mixins.json src/main/resources/
fi

# 3. Clean up old directories
rm -rf src/client src/server src/resources levelz_advancements 2>/dev/null || true

# 4. Recreate example mixin file
cat > src/main/java/com/alexkisch/levelz_advancements/mixin/ExampleModMixin.java <<'EOF'
package com.alexkisch.levelz_advancements.mixin;

import org.spongepowered.asm.mixin.Mixin;
import net.minecraft.client.MinecraftClient;

@Mixin(MinecraftClient.class)
public class ExampleModMixin {
    // TODO: Add mixin injection points here
}
EOF

# 5. Verify structure
echo ""
echo "✅ Folder cleanup complete! Your structure is now:"
find src -type d | sed 's/[^-][^\/]*\// |/g;s/|\([^ ]\)/|-- \1/'
echo ""
echo "✅ Source files:"
find src/main/java/com/alexkisch/levelz_advancements -type f | sed 's/^/   /'
