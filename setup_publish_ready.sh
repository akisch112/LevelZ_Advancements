#!/bin/bash
set -e

echo "🛠 Setting up publish-ready build configuration for LevelZ Advancements..."

# --- build.gradle ---
cat > build.gradle <<'EOG'
plugins {
    id 'fabric-loom' version '1.6.12'
    id 'maven-publish'
}

group = 'com.alexkisch.levelz_advancements'
version = '1.0.0'
archivesBaseName = 'levelz_advancements'

repositories {
    mavenCentral()
    maven { url "https://maven.fabricmc.net/" }
    maven { url "https://api.modrinth.com/maven" }
}

dependencies {
    minecraft "com.mojang:minecraft:1.20.1"
    mappings loom.officialMojangMappings()
    modImplementation "net.fabricmc:fabric-loader:0.15.11"
    modImplementation "net.fabricmc.fabric-api:fabric-api:0.90.7+1.20.1"
    modImplementation "maven.modrinth:levelz:1.4.13"
    modImplementation "maven.modrinth:libz:1.0.3"
    modImplementation "maven.modrinth:architectury-api:9.2.14+fabric"
    modImplementation "maven.modrinth:cloth-config:11.1.118+fabric"
}

loom {
    runs {
        client {
            client()
            setConfigName("Fabric Client")
            ideConfigGenerated(true)
            runDir("run")
        }
    }
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
    withSourcesJar()
}

jar {
    from("LICENSE")
}
EOG

# --- fabric.mod.json ---
mkdir -p src/main/resources
cat > src/main/resources/fabric.mod.json <<'EOM'
{
  "schemaVersion": 1,
  "id": "levelz_advancements",
  "version": "1.0.0",
  "name": "LevelZ Advancements",
  "description": "Integrates LevelZ progression with Minecraft advancements.",
  "authors": ["Alex Kisch"],
  "contact": {
    "sources": "https://github.com/alexkisch/level-z---Advancements"
  },
  "license": "MIT",
  "environment": "*",
  "entrypoints": {
    "main": [
      "com.alexkisch.levelz_advancements.LevelZAdvancements"
    ]
  },
  "depends": {
    "fabricloader": ">=0.15.11",
    "fabric-api": ">=0.90.7+1.20.1",
    "levelz": ">=1.4.13",
    "libz": ">=1.0.3",
    "architectury": ">=9.2.14",
    "cloth-config": ">=11.1.118",
    "minecraft": "1.20.1"
  }
}
EOM

# --- deploy.sh ---
cat > deploy.sh <<'EOS'
#!/bin/bash
set -e

MOD_NAME="LevelZ Advancements"
PROFILE_DIR="$HOME/Library/Application Support/ModrinthApp/profiles/$MOD_NAME"
MODS_DIR="$PROFILE_DIR/mods"
BUILD_JAR="build/libs/levelz_advancements-1.0.0.jar"

echo "🚀 Building $MOD_NAME..."
./gradlew build

if [ ! -f "$BUILD_JAR" ]; then
  echo "❌ Build failed: JAR not found at $BUILD_JAR"
  exit 1
fi

mkdir -p "$MODS_DIR"

echo "📦 Copying mod JAR to Modrinth profile..."
cp "$BUILD_JAR" "$MODS_DIR"

# Add missing dependencies automatically if needed
declare -A DEPS=(
  ["fabric-api"]="https://cdn.modrinth.com/data/P7dR8mSH/versions/0.90.7+1.20.1/fabric-api-0.90.7+1.20.1.jar"
  ["fabric-loader"]="https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.11/server/jar"
)

for dep in "${!DEPS[@]}"; do
  if ! ls "$MODS_DIR" | grep -qi "$dep"; then
    echo "⬇️ Downloading missing dependency: $dep"
    curl -L -o "$MODS_DIR/${dep}.jar" "${DEPS[$dep]}"
  fi
done

echo "✅ Mod and dependencies deployed to: $MODS_DIR"
echo "🟢 Launch Modrinth manually and start the '$MOD_NAME' profile to test."
EOS

chmod +x deploy.sh

echo "✅ Configuration complete!"
echo "➡️ Next steps:"
echo "   1. Run ./gradlew build to verify build success"
echo "   2. Run ./deploy.sh to copy mod + dependencies into Modrinth"
echo "   3. Open Modrinth and launch 'LevelZ Advancements' instance to test"
