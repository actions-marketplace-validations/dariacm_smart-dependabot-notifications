#!/bin/bash

# Release script for smart-dependabot-notifications
# Usage: ./release.sh <version>
# Example: ./release.sh 1.0.0

set -e

if [ -z "$1" ]; then
  echo "Error: Version number required"
  echo "Usage: ./release.sh <version>"
  echo "Example: ./release.sh 1.0.0"
  exit 1
fi

VERSION=$1
TAG="v${VERSION}"

echo "🔨 Building the action..."
npm run build

echo ""
echo "📦 Creating release for version ${TAG}"
echo ""

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Error: Tag ${TAG} already exists"
  exit 1
fi

# Refresh git index to avoid false positives from timestamp changes
git update-index --refresh > /dev/null 2>&1 || true

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "Error: You have uncommitted changes. Please commit or stash them first."
  exit 1
fi

echo "Creating git tags..."
git tag -a "${TAG}" -m "Release ${TAG}"
git tag -f "v${VERSION%.*.*}" # v1
git tag -f "v${VERSION%.*}"   # v1.0

echo ""
echo "Pushing tags to remote..."
git push origin "${TAG}"
git push origin "v${VERSION%.*.*}" --force
git push origin "v${VERSION%.*}" --force

echo ""
echo "✅ Tags created and pushed successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Go to https://github.com/dariacm/smart-dependabot-notifications/releases/new"
echo "2. Select tag: ${TAG}"
echo "3. Add release notes"
echo "4. Check 'Publish this Action to the GitHub Marketplace'"
echo "5. Click 'Publish release'"
echo ""
echo "Or create the release via CLI:"
echo "gh release create ${TAG} --title \"${TAG}\" --notes \"Release ${TAG}\" --generate-notes"
