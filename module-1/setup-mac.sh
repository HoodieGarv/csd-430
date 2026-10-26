#!/usr/bin/env bash
# Name:       Garvin Stewart
# Date:       October 25, 2026
# Assignment: CSD 430 Module 1 - Installation & Configuration
# Purpose:    Install Java 21, Apache Tomcat 10.1, and Eclipse (Enterprise Java)
#             on macOS via Homebrew, set environment variables, and verify each.
# Source:     Written with assistance from Claude (Anthropic AI).

set -euo pipefail

# --- Locate Homebrew (standard Apple Silicon path or a home-folder install) ---
BREW=""
for candidate in "$(command -v brew 2>/dev/null || true)" /opt/homebrew/bin/brew "$HOME/.homebrew/bin/brew" /usr/local/bin/brew; do
    if [ -n "$candidate" ] && [ -x "$candidate" ]; then BREW="$candidate"; break; fi
done
if [ -z "$BREW" ]; then
    echo "Homebrew not found. Install it from https://brew.sh, then rerun this script."
    exit 1
fi
echo "Using Homebrew at: $BREW"

# --- Install components (skips anything already installed) ---
"$BREW" install openjdk@21
"$BREW" install tomcat@10
"$BREW" install --cask eclipse-jee || echo "Eclipse cask step reported an issue (it may already be installed)."

JDK_HOME="$("$BREW" --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home"
TOMCAT_HOME="$("$BREW" --prefix tomcat@10)/libexec"

# --- Persist environment variables in ~/.zshrc (only added once) ---
MARKER="# CSD430 Java/Tomcat environment"
if ! grep -q "$MARKER" "$HOME/.zshrc" 2>/dev/null; then
    {
        echo ""
        echo "$MARKER"
        echo "export JAVA_HOME=\"$JDK_HOME\""
        echo "export CATALINA_HOME=\"$TOMCAT_HOME\""
        echo 'export PATH="$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH"'
    } >> "$HOME/.zshrc"
    echo "Added JAVA_HOME and CATALINA_HOME to ~/.zshrc"
fi
export JAVA_HOME="$JDK_HOME" CATALINA_HOME="$TOMCAT_HOME"
export PATH="$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH"

# --- Verification output (screenshot this section) ---
echo ""
echo "================ CSD 430 VERIFICATION ================"
java -version
javac -version
"$CATALINA_HOME/bin/version.sh" | grep -E "Server version|JVM Version"
ls -d /Applications/Eclipse*.app 2>/dev/null || echo "Eclipse app not found in /Applications"
echo ""
echo "Paths for Eclipse setup:"
echo "  JRE home:    $JDK_HOME"
echo "  Tomcat home: $TOMCAT_HOME"
echo "======================================================"
