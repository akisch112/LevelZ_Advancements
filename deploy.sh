#!/bin/bash
set -euo pipefail

# === Configuration ===
MOD_NAME="LevelZ Advancements"
PROFILE_DIR="$HOME/Library/Application Support/ModrinthApp/profiles/$MOD_NAME"
MODS_DIR="$PROFILE_DIR/mods"
BUILD_JAR="build/libs/levelz_advancements-1.0.0.jar"
LIBS_DIR="libs"

# === Step 0: Preflight ===
echo "🚀 Building $MOD_NAME..."

if ! command -v ./gradlew &>/dev/null; then
  echo "❌ Gradle wrapper not found. Make sure ./gradlew exists and is executable."
  exit 1
fi

# === Step 1: Build ===
./gradlew build

if [ ! -f "$BUILD_JAR" ]; then
  echo "❌ Build failed: JAR not found at $BUILD_JAR"
  exit 1
fi

# === Step 2: Ensure local dependencies exist ===
mkdir -p "$LIBS_DIR"
echo "📦 Ensuring local dependencies are present in $LIBS_DIR"

declare -A LOCAL_DEPS=(
  ["levelz-1.4.13.jar"]="https://cdn.modrinth.com/data/levelz/versions/1.4.13/levelz-1.4.13.jar"
  ["libz-1.0.3.jar"]="https://cdn.modrinth.com/data/libz/versions/1.0.3/libz-1.0.3.jar"
)

for jar in "${!LOCAL_DEPS[@]}"; do
  if [ ! -f "$LIBS_DIR/$jar" ]; then
    echo "⬇️ Missing $jar — downloading from Modrinth..."
    if ! curl -fsSL -o "$LIBS_DIR/$jar" "${LOCAL_DEPS[$jar]}"; then
      echo "⚠️ Could not download $jar automatically. Please place it in $LIBS_DIR manually."
    fi
  fi
done

# === Step 3: Copy mod jar to Modrinth profile ===
if [ ! -d "$PROFILE_DIR" ]; then
  echo "⚠️ Could not find Modrinth profile directory at:"
  echo "   $PROFILE_DIR"
  echo "Make sure the Modrinth App profile '$MOD_NAME' exists!"
else
  mkdir -p "$MODS_DIR"
  echo "📦 Deploying mod JAR..."
  cp "$BUILD_JAR" "$MODS_DIR/"
fi

# === Step 4: Copy all dependencies (Fabric + local mods) ===
echo "📦 Deploying dependencies..."
declare -A EXTERNAL_DEPS=(
  ["fabric-api"]="https://cdn.modrinth.com/data/P7dR8mSH/versions/0.90.7+1.20.1/fabric-api-0.90.7+1.20.1.jar"
  ["fabric-loader"]="https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.11/server/jar"
)

for dep in "${!EXTERNAL_DEPS[@]}"; do
  if [ -d "$MODS_DIR" ] && ! ls "$MODS_DIR" | grep -qi "$dep"; then
    echo "⬇️ Downloading missing dependency: $dep"
    curl -fsSL -o "$MODS_DIR/${dep}.jar" "${EXTERNAL_DEPS[$dep]}"
  fi
done

# Copy your local mod dependencies (LevelZ + LibZ)
if [ -d "$MODS_DIR" ]; then
  cp "$LIBS_DIR"/*.jar "$MODS_DIR/" 2>/dev/null || true
fi

# === Step 5: Summary ===
if [ -d "$MODS_DIR" ]; then
  echo "📁 Instance mods folder now contains:"
  ls -1 "$MODS_DIR"
fi

# === Step 6: Launch Modrinth App (if installed) ===
if [ -d "/Applications/Modrinth App.app" ]; then
  echo "🚀 Opening Modrinth App..."
  open -a "Modrinth App"
else
  echo "⚠️ Modrinth App not found in /Applications — skipping launch."
fi

echo "✅ Deployment complete!"
echo "🟢 Launch the '$MOD_NAME' profile in Modrinth to test."
