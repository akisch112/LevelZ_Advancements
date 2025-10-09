#!/bin/zsh
set -e

# === CONFIG ===
MOD_NAME="LevelZ Advancements"
MODRINTH_PATH="$HOME/Library/Application Support/ModrinthApp/profiles/$MOD_NAME/mods"
JAR_NAME="levelz_advancements-1.0.0.jar"
LIBS_DIR="libs"

# === BUILD ===
echo "🚀 Building $MOD_NAME..."
./gradlew build --quiet

# === VERIFY BUILD OUTPUT ===
if [ ! -f "build/libs/$JAR_NAME" ]; then
  echo "❌ Build failed — $JAR_NAME not found in build/libs"
  exit 1
fi

# === VERIFY INSTANCE ===
if [ ! -d "$MODRINTH_PATH" ]; then
  echo "⚠️ Modrinth instance not found at:"
  echo "   $MODRINTH_PATH"
  echo ""
  echo "Please create the '$MOD_NAME' instance in Modrinth first."
  exit 1
fi

# === COPY FILES ===
echo "📦 Copying mod jar to Modrinth instance..."
cp -v "build/libs/$JAR_NAME" "$MODRINTH_PATH/"

echo "📦 Copying all dependencies from /libs to instance..."
cp -v $LIBS_DIR/*.jar "$MODRINTH_PATH/" || echo "⚠️ No libs found to copy."

# === SUMMARY ===
echo ""
echo "✅ Deployment complete!"
echo "📁 Instance mods folder now contains:"
ls -1 "$MODRINTH_PATH" | sed 's/^/   /'

# === OPTIONAL: Launch Modrinth ===
if [ -d "/Applications/Modrinth App.app" ]; then
  echo ""
  echo "🚀 Opening Modrinth App..."
  open -a "Modrinth App"
else
  echo "⚠️ Modrinth App not found in /Applications."
fi
