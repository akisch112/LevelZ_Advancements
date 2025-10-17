#!/usr/bin/env bash
set -eo pipefail

# === Configuration ===
MOD_NAME="LevelZ Advancements"
MODRINTH_APP_PATH="/Applications/Modrinth App.app"
PROFILE_DIR="$HOME/Library/Application Support/ModrinthApp/profiles/$MOD_NAME"
MODS_DIR="$PROFILE_DIR/mods"
BUILD_JAR="build/libs/levelz_advancements-1.0.0.jar"
LIBS_DIR="libs"

# === Step 1: Build ===
echo "🚀 Building $MOD_NAME..."
./gradlew build

if [ ! -f "$BUILD_JAR" ]; then
    echo "❌ Build failed: JAR not found at $BUILD_JAR"
    exit 1
fi

# === Step 2: Ensure libs exist ===
mkdir -p "$LIBS_DIR"
echo "📦 Checking local dependencies..."

# Direct URLs for reference (no re-download if already there)
declare -A DEPS=(
  ["levelz-1.4.13.jar"]="https://cdn.modrinth.com/data/EFtixeiF/versions/gYSnmSW4/levelz-1.4.13.jar"
  ["libz-1.0.3.jar"]="https://cdn.modrinth.com/data/yUBXc3AH/versions/BEPAjfEE/libz-1.0.3.jar"
)

for file in "${!DEPS[@]}"; do
  if [ -f "$LIBS_DIR/$file" ]; then
    echo "✅ Found $file locally."
  else
    echo "⬇️ Downloading missing $file..."
    curl -L -o "$LIBS_DIR/$file" "${DEPS[$file]}" || {
      echo "⚠️ Could not download $file automatically. Please add it manually."
    }
  fi
done

# === Step 3: Copy mod JAR to Modrinth profile ===
mkdir -p "$MODS_DIR"
echo "📦 Deploying mod JAR to profile..."
cp "$BUILD_JAR" "$MODS_DIR/"

# === Step 4: Copy dependencies ===
echo "📦 Copying local dependencies..."
cp "$LIBS_DIR"/*.jar "$MODS_DIR/" 2>/dev/null || true

# === Step 5: Summary ===
echo "📁 Mods now in profile folder:"
ls -1 "$MODS_DIR"

# === Step 6: Launch Modrinth ===
if [ -d "$MODRINTH_APP_PATH" ]; then
    echo "🟢 Launching Modrinth App..."
    open "$MODRINTH_APP_PATH"
else
    echo "⚠️ Could not find Modrinth App in /Applications."
    echo "Please verify the app is installed and named exactly 'Modrinth App.app'."
fi

echo "✅ Deployment complete! Launch '$MOD_NAME' from Modrinth to play!"
